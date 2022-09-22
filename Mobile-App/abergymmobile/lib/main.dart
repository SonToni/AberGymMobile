import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(AberGymMobileApp());

class AberGymMobileApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AberGym',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(0, 37, 37, 50)),
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'AberGym',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
            backgroundColor: const Color.fromARGB(0, 37, 37, 50),
            centerTitle: true,
          ),
          /*body: Container(
          child: const Text(
            'Gesamtkörper Workout',
            style: TextStyle(color: Colors.lightBlue, fontSize: 24),
          ),
        ),*/
          body: Column()),
    );
  }
}
