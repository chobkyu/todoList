import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function move;

  const Button({
    super.key,
    required this.text,
    required this.move,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        move();
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 51, 50, 50),
        backgroundColor: Colors.black,
        elevation: 10.0,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
        ),
        padding: const EdgeInsets.all(13.0),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
