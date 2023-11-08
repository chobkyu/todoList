import 'package:flutter/material.dart';

import '../widgets/customAppBar.dart';

class CompleteTodo extends StatelessWidget {
  const CompleteTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 51, 50, 50),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: 'Complete'),
      ),
    );

  }
}
