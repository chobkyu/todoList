import 'package:flutter/material.dart';

class ContainerStr extends StatefulWidget {
  const ContainerStr({
    super.key,
    required this.width,
    required this.height,
    required this.data
  });

  final int width;
  final int height;
  final String data;

  @override
  State<ContainerStr> createState() => _ContainerStrState();
}

class _ContainerStrState extends State<ContainerStr> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
