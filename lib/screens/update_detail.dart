import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/widgets/customAppBar.dart';
import 'package:todolist/widgets/textStr.dart';

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

  void updateTap(){

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
            TextStr(
              fontSizeNum: 20,
              maxLine: 1,
              text: '할 일을 입력하세요',
              getStr: getTitle,
           ),
           const SizedBox(
             height: 40,
           ),
           TextStr(
             fontSizeNum: 18,
             text: 'Enter your detail here',
             getStr : getDetail,
             maxLine: 12,
           ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(onPressed:(){
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate:  DateTime.now(),
                lastDate: DateTime(2090),
              ).then((selectedDate) => setState((){
                dateTime = selectedDate;
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
              onPressed: updateTap,
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
