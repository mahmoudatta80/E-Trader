import 'package:e_commerce_app/modules/details.dart';
import 'package:e_commerce_app/modules/splash.dart';
import 'package:e_commerce_app/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Bold',
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
