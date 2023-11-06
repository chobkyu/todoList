import 'package:flutter/material.dart';

class CreateToDo extends StatefulWidget {
  const CreateToDo({super.key});

  @override
  State<CreateToDo> createState() => _CreateToDoState();
}

class _CreateToDoState extends State<CreateToDo> {
  String todo = '';
  String detail = '';
  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 50, 50),
      appBar: AppBar(
        title: const Text(
          'Create',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
