import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:e_commerce_app/modules/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/lottie/commerce_lottie.json'),
      splashIconSize: 250,
      backgroundColor: Colors.white,
      duration: 2500,
      nextScreen: LoginScreen(),
    );
  }
}
