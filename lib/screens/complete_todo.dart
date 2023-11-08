import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/customAppBar.dart';
import 'detail_page.dart';

class CompleteTodo extends StatefulWidget {
  const CompleteTodo({super.key});

  @override
  State<CompleteTodo> createState() => _CompleteTodoState();
}

class _CompleteTodoState extends State<CompleteTodo> {

  Query<Map<String, dynamic>> completeList = FirebaseFirestore.instance.collection('todo').where('doIt', isEqualTo: true);

  void detailPage() {
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
          const DetailPage(),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 50, 50),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: 'Complete'),
      ),
      body: StreamBuilder(
          stream: completeList.snapshots(),
          builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot){
              if(streamSnapshot.hasData){
                return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context,index){
                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];

                      Timestamp stamp = documentSnapshot['dateTime'];
                      DateTime date = stamp.toDate();

                      return Card(
                        color: Colors.black,
                        child: ListTile(
                          title:Text(
                            documentSnapshot['todo'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900
                            ),
                          ),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                documentSnapshot['detail'],
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }
              return const CircularProgressIndicator();
          }
      ),
    );

  }
}
