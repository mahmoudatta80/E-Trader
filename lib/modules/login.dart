import 'package:e_commerce_app/animation/animated_route.dart';
import 'package:e_commerce_app/layout/home.dart';
import 'package:e_commerce_app/modules/register.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool value = false;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'User Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      labelText: 'User Name',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      focusColor: Colors.grey,
                      prefixIcon: Icon(
                        Icons.person_outline_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: !showPassword,
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      focusColor: Colors.grey,
                      suffixIcon: !showPassword
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              icon: Icon(
                                Icons.visibility_off_outlined,
                                color: Colors.grey,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              icon: Icon(
                                Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                            ),
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: value,
                        activeColor: Colors.indigo,
                        onChanged: (value) {
                          this.value = value as bool;
                          setState(() {});
                        },
                      ),
                      Text(
                        'Remember Me',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forget Password ?',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        AnimatedRoute(page: HomeLayout(currentIndex: 0,)),
                      );
                    },
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'if you haven\'t an account ',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            AnimatedRoute(
                              page: RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
