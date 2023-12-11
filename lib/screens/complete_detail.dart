import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/fail_popup.dart';
import 'package:todolist/widgets/containerStr.dart';
import 'package:todolist/widgets/customAppBar.dart';

import '../widgets/textStr.dart';

class CompleteDetail extends StatefulWidget {
  const CompleteDetail({super.key,required this.snapshot});

  final DocumentSnapshot? snapshot;
  @override
  State<CompleteDetail> createState() => _CompleteDetailState();
}

class _CompleteDetailState extends State<CompleteDetail> {
  //auth
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  String reason = '';

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
      }
    }catch(err){
      print(err);
    }
  }
  
  String getTime(Timestamp time) {
    DateTime date = time.toDate();
    return date.toString();
  }

  bool checkTime(Timestamp startTime,Timestamp completeTime){
    DateTime dateCreate = startTime.toDate();
    DateTime dateComplete = completeTime.toDate();

    return dateComplete.isAfter(dateCreate);
  }


  void getReason(String str){
    setState(() {
      reason = str;
    });
  }

  void saveReason(DocumentSnapshot? snapshot) async {
    insertReason(snapshot);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  Future<void> insertReason(DocumentSnapshot? snapshot) async {
    String? userId = loggedUser?.email;
    String detail = snapshot?['detail'] + "\n\n\n늦은 이유 : "+reason;
    return await FirebaseFirestore.instance.collection('todo').doc(userId).collection(userId!).doc(snapshot?.id).set(
      {
        'todo':snapshot?['todo'],
        'detail':detail,
        'dateTime':snapshot?['dateTime'],
        'doIt':true,
        'completeTime':snapshot?['completeTime']
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 50, 50),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: 'Complete Detail')
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ContainerStr(
                width: 350,
                height: 38,
                data: widget.snapshot?.get('todo')
            ),
            const SizedBox(
              height: 30,
            ),
            ContainerStr(
                width: 350,
                height: 350,
                data: widget.snapshot?.get('detail')
            ),
            const SizedBox(
              height: 30,
            ),
            ContainerStr(
                width: 350,
                height: 38,
                data: '예정 시간 :${getTime(widget.snapshot?.get('dateTime'))}'
            ),
            const SizedBox(
              height: 10,
            ),
            ContainerStr(
                width: 350,
                height: 38,
                data: '완료 시간 :${getTime(widget.snapshot?.get('completeTime')??'')}'
            ),
            const SizedBox(
              height: 10,
            ),
            if(checkTime(widget.snapshot?.get('dateTime'), widget.snapshot?.get('completeTime')))
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 1
                ),
              onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,

                      builder:(BuildContext context){
                        return AlertDialog(

                          backgroundColor: const Color.fromARGB(255, 51, 50, 50),
                          content: Container(
                            color: const Color.fromARGB(255, 51, 50, 50),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Enter your reason',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 300,
                                  child: TextStr(
                                      fontSizeNum: 18,
                                      text: 'enter!!',
                                      getStr: getReason,
                                      maxLine: 1
                                  ),
                                )

                              ],
                            ),
                          ),
                          insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                          actions:[
                            TextButton(
                              onPressed: () {
                                saveReason(widget.snapshot);
                              },
                              child:const Text(
                                '저장',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () { Navigator.of(context).pop(); },
                              child:const Text(
                                  '확인',
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                              ),
                            ),
                          ]
                        );
                      }
                  );
              },
              child: const Text(
                "Why?",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
