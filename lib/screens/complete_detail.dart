import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/widgets/customAppBar.dart';

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
            Container(
              color: Colors.black,
              width: 350,
              height: 38,
              child: Text(
                "${widget.snapshot?.get('todo')}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              color:Colors.black,
              width: 350,
              height: 350,
              child: Text(
                "${widget.snapshot?.get('detail')}",
                style: const TextStyle(
                  color:Colors.white,
                  fontSize: 20
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              color:Colors.black,
              width: 350,
              height: 38,
              child: Text(
                getTime(widget.snapshot?.get('dateTime')),
                style: const TextStyle(
                  color:Colors.white,
                  fontSize: 20
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
