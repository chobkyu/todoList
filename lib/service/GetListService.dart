import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/TodoModel.dart';

class GetListService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ToDoModel>> getList() async {
    QuerySnapshot<Map<String,dynamic>> _snapshot = await _firestore.collection('todo').get();
    List<ToDoModel> _result = _snapshot.docs.map((e)=> ToDoModel.fromJson(e.data())).toList();

    print(_result);
    return _result;
  }
}