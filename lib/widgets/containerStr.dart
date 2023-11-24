import 'package:flutter/material.dart';

class ContainerStr extends StatefulWidget {
  const ContainerStr({
    super.key,
    required this.width,
    required this.height,
    required this.data
  });

  final double width;
  final double height;
  final String data;

  @override
  State<ContainerStr> createState() => _ContainerStrState();
}

class _ContainerStrState extends State<ContainerStr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: widget.width,
      height: widget.height,
      child: Text(
        widget.data,
        style: const TextStyle(
          color:Colors.white,
          fontSize: 20
        ),
      ),
    );
  }
}
