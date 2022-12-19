// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:abergymmobile/home/Home.dart';
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
    _timer = Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        //Transition
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
      body: Center(
        child: Text(
          "Hallo $name \n Willkommen zurück!",
          style: TextStyle(color: lightblue, fontSize: 38),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
