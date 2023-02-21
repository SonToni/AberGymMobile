// ignore_for_file: file_names, must_be_immutable, no_logic_in_create_state

import 'dart:async';
import 'package:abergymmobile/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class WelcomeSplashPage extends StatefulWidget {
  String name;
  WelcomeSplashPage(this.name, {super.key});

  @override
  State<WelcomeSplashPage> createState() => _WelcomeSplashPageState(name);
}

class _WelcomeSplashPageState extends State<WelcomeSplashPage> {
  String name = "";
  final Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);
  final Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  late Timer _timer;

  _WelcomeSplashPageState(this.name);

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          child: const LoginPage(),
          reverseDuration: const Duration(milliseconds: 500),
          alignment: Alignment.center,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.lightBlue[800]!,
              Colors.lightBlue[400]!,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "AberGym",
                  style: GoogleFonts.montserrat(
                    color: darkgrey,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.fitness_center,
                  color: darkgrey,
                  size: 50,
                  shadows: const <Shadow>[
                    Shadow(
                      color: Colors.white,
                      blurRadius: 20.0,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              width: 200,
              child: Center(
                child: Divider(
                  thickness: 1,
                  color: darkgrey,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hallo',
                  style: GoogleFonts.montserrat(
                    color: darkgrey,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 10),
                Text(
                  name,
                  style: GoogleFonts.montserrat(
                    color: Colors.lightBlue[800]!,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Text(
              '\nWir freuen uns, dass du heute da bist!',
              style: GoogleFonts.montserrat(
                color: darkgrey,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
