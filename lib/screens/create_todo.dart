import 'package:flutter/material.dart';

class CreateToDo extends StatelessWidget {
  const CreateToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [Text('todolist')],
        ),
      ),
    );
  }
}
