import 'package:cloud_firestore/cloud_firestore.dart';


class CreateTodoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String todo;
  String detail;
  DateTime dateTime;

  CreateTodoService(this.todo, this.detail, this.dateTime);

  Future<void> insertTodo(userId) async {
    try{
      await _firestore.collection('todo').doc(userId).collection(userId).doc().set({
        "todo":todo,
        "detail":detail,
        "dateTime":dateTime,
        "doIt":false
      });
    }catch(err){
      print(err);
    }

    // await _firestore.collection('todo').doc().set({
    //   "todo": todo,
    //   "detail": detail,
    //   "dateTime": dateTime,
    //   "doIt":false,
    // });
  }

}
