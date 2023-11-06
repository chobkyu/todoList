import 'package:flutter/material.dart';
import 'package:todolist/widgets/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 50, 50),
      appBar: AppBar(
        title: const Center(
          child: Text(
            'To Do list',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 200,
          horizontal: 30,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Button(
                  text: 'todolist',
                  move: () {
                    print('list page');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Button(
                  text: 'make to do',
                  move: () {
                    print('make to do');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Button(
                    text: 'complete',
                    move: () {
                      print('complete page');
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
