import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoModel{
  final String todo,detail,id;
  final Timestamp dateTime;
  final bool doIt;

  ToDoModel.fromJson(Map<String,dynamic> json)
    : todo = json['todo'],
      detail = json['detail'],
      id = json['id'],
      dateTime = json['dateTime'],
      doIt = json['doIt'];
}