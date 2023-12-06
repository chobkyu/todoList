import 'package:flutter/material.dart';
import 'package:todolist/widgets/textStr.dart';

class FailPopUp extends StatefulWidget {
  const FailPopUp({
    super.key,

  });



  @override
  State<FailPopUp> createState() => _FailPopUpState();
}

class _FailPopUpState extends State<FailPopUp> {
  String reason = '';

  void getReason(String str){
    setState(() {
      reason = str;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
