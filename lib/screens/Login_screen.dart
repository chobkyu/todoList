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
          AnimatedPositioned(
                duration: Duration(milliseconds: 100),
                curve: Curves.easeIn,
                top:180,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  padding: const EdgeInsets.all(20),
                  height:isSignupScreen ? 280.0 : 250.0,
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
                      if(isSignupScreen)
                      Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                        Icons.account_circle,
                                        color : Colors.white,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide : BorderSide(
                                        color : Colors.white
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color : Colors.white,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                    ),
                                    hintText: 'User Name',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey
                                    ),
                                    contentPadding: EdgeInsets.all(10)
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color : Colors.white,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide : BorderSide(
                                            color : Colors.white
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color : Colors.white,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35),
                                        ),
                                      ),
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color : Colors.white,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide : BorderSide(
                                            color : Colors.white
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color : Colors.white,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35),
                                        ),
                                      ),
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      if(!isSignupScreen)
                      Container(
                        margin: EdgeInsets.only(top:20),
                        child: Form(
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.account_circle,
                                      color : Colors.white,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide : BorderSide(
                                          color : Colors.white
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color : Colors.white,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                    ),
                                    hintText: 'User Name',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey
                                    ),
                                    contentPadding: EdgeInsets.all(10)
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color : Colors.white,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide : BorderSide(
                                          color : Colors.white
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color : Colors.white,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey
                                    ),
                                    contentPadding: EdgeInsets.all(10)
                                ),
                              ),
                            ],
                          ),
                        ),

                      )
                    ],
                  ),
                ),
            ),
          //text
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve:Curves.easeIn,
            top: isSignupScreen ? 430 : 390,
            right:0,
            left:0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(15),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.black, //update
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient : const LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.grey,
                      ],
                      begin: Alignment.topLeft,
                      end : Alignment.bottomRight
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          //button,
          Positioned(
              top: MediaQuery.of(context).size.height-240,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  const Text(
                      'or Signup with',
                      style: TextStyle(
                        color: Colors.white
                      ),
                  ),
                  TextButton.icon(
                      onPressed: (){},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white, minimumSize: const Size(155,40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        backgroundColor: Colors.black
                      ),
                      icon: Icon(Icons.add),
                      label: Text('Google'),
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}
