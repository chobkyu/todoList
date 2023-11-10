import 'package:flutter/material.dart';
import 'package:todolist/screens/home_screen.dart';
import 'package:todolist/service/CreateTodoService.dart';
import 'package:todolist/widgets/textStr.dart';

import '../widgets/customAppBar.dart';

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

  void getDetail(String str){
    setState(() {
      detail = str;
    });
  }

  void createTap(){
    var createTodoService = CreateTodoService(todo, detail, dateTime!);
    if(todo==''||detail==''||dateTime==null){
      return;
    }
    createTodoService.insertTodo();
    _showDialog();
  }

  void _showDialog(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Alert'),
        content: const Text("등록 완료"),
        actions: <Widget>[
          BackButton(
            onPressed: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context){
                    return const HomeScreen();
                  },
                ),
              );
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
        child:  CustomAppBar(title: 'Create'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            TextStr(
                fontSizeNum: 20,
                text: '할 일을 입력하세요',
                getStr: getTitle,
                maxLine: 1,
            ),
            const SizedBox(
              height: 40,
            ),
            TextStr(
              fontSizeNum: 18,
              text: 'Enter your detail here',
              getStr: getDetail,
              maxLine: 12,
            ),
            ElevatedButton(onPressed:(){
              showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate:  DateTime.now(),
                  lastDate: DateTime(2090),
                ).then((selectedDate) => setState((){
                  dateTime = selectedDate;
                }));},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation : 1 ,
                ),
                child: const Text(
                  "기한 선택",
                  style: TextStyle(
                    color:Colors.white,
                  ),
                ),
            ),
            ElevatedButton(
                onPressed: createTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 1
                ),
                child: const Text(
                  "Create",
                  style: TextStyle(
                    color:Colors.white,
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
