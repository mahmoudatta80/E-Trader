import 'package:flutter/material.dart';

class AnimatedRoute extends PageRouteBuilder {
  final page;

  AnimatedRoute({this.page})
      : super(
          pageBuilder: (context, animation, secondAnimation) => page,
          transitionsBuilder: (context, animation, secondAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset(0.0, 0.0);
            final tween = Tween(begin: begin, end: end);
            final curveAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.linear,
            );
            return SlideTransition(
              position: tween.animate(curveAnimation),
              child: child,
            );
          },
        );
}
