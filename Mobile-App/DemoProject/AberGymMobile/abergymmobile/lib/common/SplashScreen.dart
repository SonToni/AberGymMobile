// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:abergymmobile/home/Home.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  String name;

  SplashScreen(this.name);

  @override
  _SplashScreenState createState() => _SplashScreenState(name);
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  String name = "";
  final Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);
  final Color lightblue = const Color.fromARGB(255, 42, 195, 255);

  _SplashScreenState(this.name);

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          child: Home(),
          reverseDuration: Duration(milliseconds: 500),
          alignment: Alignment.center,
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkgrey,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                RotateAnimatedText(
                  'Hallo $name \n Wir freuen uns, dass du heute da bist!',
                  textStyle: TextStyle(
                    fontSize: 28,
                    color: lightblue,
                  ),
                  textAlign: TextAlign.center,
                ),
                RotateAnimatedText(
                  'Nur Heute: \n Jeder Energydrink 1€',
                  textStyle: TextStyle(
                    fontSize: 28,
                    color: lightblue,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
