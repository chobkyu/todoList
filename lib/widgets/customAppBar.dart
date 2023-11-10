import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/Login_screen.dart';

class CustomAppBar extends StatefulWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
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

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      backgroundColor: Colors.black,
      centerTitle: true,
      actions: [
        //if(!isLogin)
        IconButton(
          icon: const Icon(
            Icons.exit_to_app_sharp,
            color: Colors.white,
          ),
          onPressed: (){
            _authentication.signOut();
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
          },
        )
      ],
    );
  }
}
