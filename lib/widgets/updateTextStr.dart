import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateTextStr extends StatefulWidget {
  final double fontSizeNum;
  final String text;
  final Function getStr;
  final int maxLine;

  const UpdateTextStr({
    super.key,
    required this.fontSizeNum,
    required this.text,
    required this.getStr,
    required this.maxLine,
  });

  @override
  State<UpdateTextStr> createState() => _UpdateTextStrState();
}

class _UpdateTextStrState extends State<UpdateTextStr> {
  final _authentication = FirebaseAuth.instance;

  bool isLogin = false;
  User? loggedUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 102, 100, 100),
      child: TextFormField(
        initialValue: widget.text,
        maxLines: widget.maxLine,
        style: TextStyle(
          fontSize: widget.fontSizeNum,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText:widget.text,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 202, 194, 194),
          ),
        ),
        onChanged: (String str){
          widget.getStr(str);
        }
      ),
    );
  }
}
