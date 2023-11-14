import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/Login_screen.dart';
import 'package:todolist/screens/complete_todo.dart';
import 'package:todolist/screens/create_todo.dart';
import 'package:todolist/screens/todoList.dart';
import 'package:todolist/widgets/button.dart';

import '../widgets/customAppBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){
    try{
      final user = _authentication.currentUser;
      if(user != null){
        print(user);
        loggedUser = user;
        isLogin = true;
      }
    }catch(err){
      print(err);
    }

  }

  void goToLoginPage(){
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) =>
        const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 50, 50),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child:  CustomAppBar(title: 'To Do List'),
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
                    if(loggedUser!=null){
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                          pageBuilder: (context, animation, secondaryAnimation) =>
                          const TodoList(),
                        ),
                      );
                    }else{
                      goToLoginPage();
                    }

                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Button(
                  text: 'make to do',
                  move: () {
                    if(loggedUser!=null){
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                          pageBuilder: (context, animation, secondaryAnimation) =>
                          const CreateToDo(),
                        ),
                      );
                    }else{
                      goToLoginPage();
                    }

                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Button(
                    text: 'complete',
                    move: () {
                      if(loggedUser!=null){
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
                              var begin = const Offset(0.0, 1.0);
                              var end = Offset.zero;
                              var curve = Curves.ease;
                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                            const CompleteTodo(),
                          ),
                        );
                      }else{
                        goToLoginPage();
                      }

                    }
                ),
                const SizedBox(
                  height: 10,
                ),
                if(!isLogin)
                Button(
                    text: 'Login',
                    move: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                          const LoginPage(),
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
