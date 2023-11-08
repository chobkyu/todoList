import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/todoList.dart';
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

  Future<void> updateDoIt(DocumentSnapshot snapshot) async {
    await FirebaseFirestore.instance.collection('todo').doc(snapshot.id).set(
        {
          'todo':snapshot['todo'],
          'detail':snapshot['detail'],
          'dateTime':snapshot['dateTime'],
          'doIt':true,
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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context){
                    return const TodoList();
                  }));
            },
          )
        ],
      );
    });
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
            Container(
              color: Colors.black,
              width: 350,
              height: 38,
              child: Text(
                "${widget.snapshot?.get('todo') ?? 'n'}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.black,
              width: 350,
              height: 350,
              child: Text(
                "${widget.snapshot?.get('detail') ?? 'n'}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.black,
              width: 350,
              height: 38,
              child: Text(
                getTime(widget.snapshot?.get('dateTime')),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
            ),
            const SizedBox(
              width: 110,
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
          ],
        ),
      )
    );
  }
}
