import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/TodoModel.dart';

class GetListService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ToDoModel>> getList() async {


      List<ToDoModel> todoList = [];

      _firestore.collection('todo').where("doIt", isEqualTo: false).get().then((
          querySnapshot) {
            print("successfully complete");
            for (var docSnapshot in querySnapshot.docs)
            {
              print('${docSnapshot.id} => ${docSnapshot.data()}');

              ToDoModel todoMoel = ToDoModel.fromJson({
                "todo":docSnapshot.data()['todo'],
                "detail":docSnapshot.data()['detail'],
                "id":docSnapshot.id,
                "dateTime":docSnapshot.data()['dateTime'],
                "doIt":docSnapshot.data()['doIt'],
              });
              todoList.add(todoMoel);
              print(todoList[0]);
            }
        },
        onError: (e) => print("Error completing: $e"),
      );


      // QuerySnapshot<Map<String,dynamic>> _snapshot = await _firestore.collection('todo').get();
      // List<ToDoModel> _result = _snapshot.docs.map((e)=> ToDoModel.fromJson(e.data())).toList();
      //
      // print(_result);

      return todoList;


  }
}