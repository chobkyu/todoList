import 'package:flutter/material.dart';

class TextStr extends StatelessWidget {
  final double fontSizeNum;
  final String text;
  final Function getStr;
  final int maxLine;

  const TextStr({
    super.key,
    required this.fontSizeNum,
    required this.text,
    required this.getStr,
    required this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 102, 100, 100),
      child: TextField(
        maxLines: maxLine,
        style: TextStyle(
          fontSize: fontSizeNum,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 202, 194, 194),
          ),
        ),
        onChanged: (String str) {
          getStr(str);
        },
      ),
    );
  }
}
