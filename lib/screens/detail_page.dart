import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/todoList.dart';
import 'package:todolist/screens/update_detail.dart';
import 'package:todolist/widgets/containerStr.dart';
import 'package:todolist/widgets/customAppBar.dart';

import 'home_screen.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key,required this.snapshot});

  final DocumentSnapshot? snapshot;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  String getTime(Timestamp time) {
    DateTime date = time.toDate();
    return date.toString();
  }

  String getRemainTime(Timestamp time){
    DateTime date = time.toDate();
    var _nowDay = DateTime.now();

    Duration difference = date.difference(_nowDay);
    print('${difference.inDays}일 ${difference.inHours}시간 ${difference.inMinutes}분 남음');
    return '남은 기간 : ${difference.inDays}일 ';
  }

  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
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
        print(user);
        loggedUser = user;
      }
    }catch(err){
      print(err);
    }
  }

  Future<void> updateDoIt(DocumentSnapshot snapshot) async {
    String? userId = loggedUser?.email;
    print(userId);
    DateTime dt = DateTime.now();
    await FirebaseFirestore.instance.collection('todo').doc(userId).collection(
        userId!).doc(snapshot.id).set(
        {
          'todo': snapshot['todo'],
          'detail': snapshot['detail'],
          'dateTime': snapshot['dateTime'],
          'doIt': true,
          'completeTime':dt,
        }
    );
    _showDialog();
  }

  void _showDialog(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Alert'),
        content: const Text("Complete"),
        actions: <Widget>[
          BackButton(
            onPressed: (){
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(builder: (context){
              //       return const TodoList();
              //     }));
              Navigator.of(context).pop();
              Navigator.of(context).pop();

            },
          )
        ],
      );
    });
  }

  void updatePage(DocumentSnapshot snapshot){
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
              UpdateDetail(snapshot: snapshot),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 50, 50),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(title: 'Detail Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ContainerStr(
                width: 350,
                height: 38,
                data: widget.snapshot?.get('todo')
            ),
            const SizedBox(
              height: 30,
            ),
            ContainerStr(
                width: 350,
                height: 350,
                data: widget.snapshot?.get('detail')
            ),
            const SizedBox(
              height: 30,
            ),
            ContainerStr(
                width: 350,
                height: 38,
                data: getTime(widget.snapshot?.get('dateTime'))
            ),
            const SizedBox(
              height: 10,
            ),
            ContainerStr(
                width: 350,
                height: 38,
                data: getRemainTime(widget.snapshot?.get('dateTime'))
            ),
            const SizedBox(
              width: 110,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 100,
                ),
                ElevatedButton(
                  onPressed: (){
                    updateDoIt(widget.snapshot!);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 1
                  ),
                  child: const Text(
                      'Do it?'
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: (){
                    updatePage(widget.snapshot!);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 1
                  ),
                  child: const Text(
                      'update'
                  ),
                ),
              ],
            ),

          ],
        ),
      )
    );
  }
}
