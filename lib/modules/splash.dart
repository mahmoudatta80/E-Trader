import 'package:e_commerce_app/animation/animated_route.dart';
import 'package:e_commerce_app/modules/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 3,
        ));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!)
      ..addStatusListener((status) {})
      ..addListener(() {
        setState(() {});
      });
    _controller!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: AnimatedOpacity(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(
              seconds: 3,
            ),
            opacity: _animation!.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage(
                    'assets/images/e-commerce.jpg',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Welcome to our community',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
            onEnd: () {
              Navigator.of(context).pushAndRemoveUntil(
                  AnimatedRoute(page: LoginScreen()), (route) => false);
            },
          ),
        ),
      ),
    );
  }
}
