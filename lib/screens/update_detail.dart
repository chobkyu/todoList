import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/todoList.dart';
import 'package:todolist/widgets/customAppBar.dart';
import 'package:todolist/widgets/textStr.dart';

import '../widgets/updateTextStr.dart';

class UpdateDetail extends StatefulWidget {
  const UpdateDetail({super.key,required this.snapshot});

  final DocumentSnapshot? snapshot;
  @override
  State<UpdateDetail> createState() => _UpdateDetailState();
}

class _UpdateDetailState extends State<UpdateDetail> {
  String todo = '';
  String detail = '';
  DateTime? dateTime;

  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  String? userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){
    try{
      final user = _authentication.currentUser;
      if(user != null){
        print(user);
        loggedUser = user;
        userId = loggedUser?.email;
      }
    }catch(err){
      print(err);
    }
  }

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

  void updateTap(dynamic snapshot) {
    if(todo=='') todo = snapshot.get('todo');
    if(detail=='') detail = snapshot.get('detail');
    dateTime ??= snapshot.get('dateTime').toDate();
    updateDoIt(snapshot.id);
    _showDialog();

  }

  Future<void> updateDoIt(id) async {
    return await FirebaseFirestore.instance.collection('todo').doc(userId).collection(userId!).doc(id).set(
        {
          'todo':todo,
          'detail':detail,
          'dateTime':dateTime,
          'doIt':false,
        }
    );
  }

  String getDate(stamp){
    print(dateTime);

    if(dateTime!=null){
      print(dateTime);
      return dateTime.toString();
    }else{
      DateTime date = stamp.toDate();
      return date.toString();
    }

  }

  void _showDialog(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Alert'),
        content: const Text("등록 완료"),
        actions: <Widget>[
          BackButton(
            onPressed: (){
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(builder: (context){
              //       return const TodoList();
              //     },
              //   ),
              // );
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();

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
          child: CustomAppBar(title: 'Update'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            UpdateTextStr(
              fontSizeNum: 20,
              maxLine: 1,
              text: widget.snapshot?.get('todo'),
              getStr: getTitle,
           ),
           const SizedBox(
             height: 40,
           ),
            UpdateTextStr(
             fontSizeNum: 18,
             text: widget.snapshot?.get('detail'),
             getStr : getDetail,
             maxLine: 12,
           ),
            const SizedBox(
              height: 40,
            ),
            UpdateTextStr(
              fontSizeNum: 18,
              text: dateTime == null? getDate(widget.snapshot?.get('dateTime')):dateTime.toString(),
              getStr : (){},
              maxLine: 1,
            ),
            ElevatedButton(onPressed:(){
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate:  DateTime.now(),
                lastDate: DateTime(2090),
              ).then((selectedDate) => setState((){
                dateTime = selectedDate;
                getDate(dateTime);
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
              onPressed: (){
                print(widget.snapshot?.data());
                updateTap(widget.snapshot);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 1
              ),
              child: const Text(
                "Update",
                style: TextStyle(
                  color:Colors.white,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
