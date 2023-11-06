import 'package:cloud_firestore/cloud_firestore.dart';

class CreateTodoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String todo;
  String detail;
  DateTime dateTime;

  CreateTodoService(this.todo, this.detail, this.dateTime);

  Future<void> insertTodo() async {
    await _firestore.collection('todo').doc().set({
      "todo": todo,
      "detail": detail,
      "dateTime": dateTime,
    });
  }
}
