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
  final Future<List<ToDoModel>> todoList = GetListService().getList();

  void testList(){
    print(todoList);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 51 , 50, 50),
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(50),
        child:  CustomAppBar(title: 'todo List'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            ElevatedButton(onPressed:(){ print(todoList);}, child: Text('test'))
          ],
        ),
      ),
    );
  }
}
