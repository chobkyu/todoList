import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/service/CreateTodoService.dart';
import 'package:todolist/service/GetListService.dart';
import 'package:todolist/widgets/customAppBar.dart';

import '../models/TodoModel.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  Query<Map<String, dynamic>> todolist = FirebaseFirestore.instance.collection('todo').where('doIt', isEqualTo: false);

  void detailPage() {

  }

  Future<void> updateDoIt(String uid) async {
    return await FirebaseFirestore.instance.collection('todo').doc(uid).set(
        {
          'doIt':true,
        }
    );
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
          if (streamSnapshot.hasData) {
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
                      onTap: detailPage,
                      title: Text(
                        documentSnapShot['todo'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900
                        ),
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
                              Text(
                                  documentSnapShot['detail'],
                                  style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                date.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],

                          ),
                          const SizedBox(
                            width: 110,
                          ),
                          ElevatedButton(
                              onPressed: (){
                                updateDoIt(documentSnapShot.id);
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
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
