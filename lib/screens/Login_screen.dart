import 'package:flutter/material.dart';
import 'package:todolist/widgets/customAppBar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSignupScreen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 50, 50),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(title: 'Login'),
      ),
      body: Stack(
        children: [
            Positioned(
                top:180,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height:280.0,
                  width: MediaQuery.of(context).size.width-40,
                  margin:const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isSignupScreen = false;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen ? Colors.white:Colors.grey,
                                  ),
                                ),
                                if(!isSignupScreen)
                                Container(
                                  margin: const EdgeInsets.only(top:3),
                                  height: 2,
                                  width: 55,
                                  color: !isSignupScreen ? Colors.white:Colors.grey,
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isSignupScreen = true;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'SIGNUP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen ? Colors.white:Colors.grey,
                                  ),
                                ),
                                if(isSignupScreen)
                                Container(
                                  margin: const EdgeInsets.only(top:3),
                                  height: 2,
                                  width: 55,
                                  color: isSignupScreen ? Colors.white:Colors.grey,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                          child: Form(
                            child: Column(
                              children: [
                                TextFormField(


                                ),
                              ],
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
            ),
        ],
      ),
    );
  }
}
