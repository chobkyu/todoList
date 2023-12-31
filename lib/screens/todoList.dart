import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/detail_page.dart';
import 'package:todolist/service/CreateTodoService.dart';
import 'package:todolist/service/GetListService.dart';
import 'package:todolist/widgets/customAppBar.dart';
import 'package:todolist/widgets/notice.dart';

import '../models/TodoModel.dart';
import '../widgets/button.dart';
import 'Login_screen.dart';
import 'create_todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  //late String userEmail;
  late Query<Map<String,dynamic>> todolist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){
    try{
      final user = _authentication.currentUser;
      if(user != null){
        //print(user);
        loggedUser = user;
        String? userEmail = loggedUser?.email;
        todolist = FirebaseFirestore.instance.collection('todo').doc(userEmail).collection(userEmail!).where('doIt', isEqualTo: false);
        //print(todolist);
      }else{
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween = Tween(begin: begin, end: end)
                  .chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginPage(),
          ),
        );
      }
    }catch(err){
      print(err);
    }
  }

  void detailPage(DocumentSnapshot snapshot) {
      Navigator.push(
          context,
          PageRouteBuilder(
          transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) =>
        DetailPage(snapshot:snapshot),
        )
    );
  }

  Future<void> updateDoIt(DocumentSnapshot snapshot) async {
    String? userId = loggedUser?.email;
    DateTime dt = DateTime.now();
    return await FirebaseFirestore.instance.collection('todo').doc(userId).collection(userId!).doc(snapshot.id).set(
        {
          'todo':snapshot['todo'],
          'detail':snapshot['detail'],
          'dateTime':snapshot['dateTime'],
          'doIt':true,
          'completeTime':dt,
        }
    );
  }

  void goToLoginPage(){
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) =>
        const LoginPage(),
      ),
    );
  }

  int getRemainTime(Timestamp time){
    DateTime date = time.toDate();
    var _nowDay = DateTime.now();

    Duration difference = date.difference(_nowDay);
    print('${difference.inDays}일 ${difference.inHours}시간 ${difference.inMinutes}분 남음');
    return difference.inDays;
  }

  bool checkTime(Timestamp time){
    DateTime date = time.toDate();
    // final difference = date.difference(DateTime.now());
    var now = DateTime.now();
    return now.isAfter(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 50, 50),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: 'todo List'),
      ),
      body: StreamBuilder(
        stream: todolist.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {

          if(streamSnapshot.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          }
          if (streamSnapshot.hasData) {
            print(streamSnapshot.data);
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {


                final DocumentSnapshot documentSnapShot =
                streamSnapshot.data!.docs[index];

                  Timestamp stamp = documentSnapShot['dateTime'];
                  DateTime date = stamp.toDate();

                  return Card(
                    color: Colors.black,
                    child: ListTile(
                      onTap: (){detailPage(documentSnapShot);},
                      title: Row(
                        children: [
                          Text(
                            documentSnapShot['todo'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if(getRemainTime(documentSnapShot['dateTime'])<2&&getRemainTime(documentSnapShot['dateTime'])>0)
                          const NoticeWidget(text: ' hurry! ', color: Colors.deepOrange)
                          else if(checkTime(documentSnapShot['dateTime']))
                          const NoticeWidget(text: ' fail.. ', color: Colors.deepPurple)
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width:200,
                                child: Text(
                                  documentSnapShot['detail'],
                                  style: const TextStyle(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ),
                              Text(
                                date.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],

                          ),
                          const SizedBox(
                            width: 70,
                          ),
                          ElevatedButton(
                              onPressed: (){
                                updateDoIt(documentSnapShot);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 51, 50, 50),
                                  elevation: 1
                              ),
                              child: const Text(
                                  'Do it?'
                              ),
                          ),
                        ],
                      ),

                    ),
                  );
                });
          // }else if(streamSnapshot.data==null){
          //   print('nullnull');
          //   return ListView.builder(
          //     itemCount: streamSnapshot.data?.docs.length,
          //     itemBuilder: (context, index) {
          //       return Center(
          //         child: Column(
          //           children: [
          //             const SizedBox(
          //               height: 100,
          //             ),
          //             const Text(
          //               'no data',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 10,
          //               ),
          //             ),
          //             Button(
          //               text: 'make to do',
          //               move: () {
          //                 if(loggedUser!=null){
          //                   Navigator.push(
          //                     context,
          //                     PageRouteBuilder(
          //                       transitionsBuilder:
          //                           (context, animation, secondaryAnimation, child) {
          //                         var begin = const Offset(0.0, 1.0);
          //                         var end = Offset.zero;
          //                         var curve = Curves.ease;
          //                         var tween = Tween(begin: begin, end: end)
          //                             .chain(CurveTween(curve: curve));
          //                         return SlideTransition(
          //                           position: animation.drive(tween),
          //                           child: child,
          //                         );
          //                       },
          //                       pageBuilder: (context, animation, secondaryAnimation) =>
          //                       const CreateToDo(),
          //                     ),
          //                   );
          //                 }else{
          //                   goToLoginPage();
          //                 }
          //
          //               },
          //             ),
          //           ],
          //         ),
          //       );
          //     }
          //
          //   );

          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

