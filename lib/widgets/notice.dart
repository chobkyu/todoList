import 'package:flutter/material.dart';

class NoticeWidget extends StatefulWidget {
  final String text;
  final Color color;

  const NoticeWidget({
    super.key,
    required this.text,
    required this.color
  });


  @override
  State<NoticeWidget> createState() => _NoticeWidgetState();
}

class _NoticeWidgetState extends State<NoticeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:widget.color
      ),
      child: Text(
        widget.text,
        style: const TextStyle(
          color:Colors.white
        ),
      ),
    );
  }
}
