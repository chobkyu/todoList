import 'package:flutter/material.dart';
import 'package:todolist/widgets/textStr.dart';

class CreateToDo extends StatefulWidget {
  const CreateToDo({super.key});

  @override
  State<CreateToDo> createState() => _CreateToDoState();
}

class _CreateToDoState extends State<CreateToDo> {
  String todo = '';
  String detail = '';
  DateTime? dateTime;

  void getTitle(String str) {
    setState(() {
      todo = str;
    });
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            TextStr(
                fontSizeNum: 24,
                text: '할 일을 입력하세요',
                getStr: getTitle,
                maxLine: 1)
          ],
        ),
      ),
    );
  }
}
