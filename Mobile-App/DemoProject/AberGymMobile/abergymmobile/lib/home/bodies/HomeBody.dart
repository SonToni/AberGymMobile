// ignore_for_file: must_be_immutable, file_names

import 'package:abergymmobile/common/SqlTable.dart';
import 'package:abergymmobile/progress/Main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key});

  double shape = 0.0;
  Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SqlTable(version: 1),
      bottomNavigationBar: ElevatedButton(
        onPressed: (() async {
          final prefs = await SharedPreferences.getInstance();
          int amountrows = await prefs.getInt('amountrows')!;
          int countTrue = 0;

          for (int i = 0; i < amountrows; i++) {
            if (prefs.getBool('finishedExcersice_$i') == true) {
              countTrue++;
            }
          }
          if (countTrue == amountrows) {
            for (int i = 0; i < amountrows; i++) {
              prefs.remove('finishedExcersice_$i');
            }
          }
          _navigateToNextScreen(context);
        }),
        style: ElevatedButton.styleFrom(
          backgroundColor: darkgrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(shape),
              topLeft: Radius.circular(shape),
            ),
          ),
        ),
        child: const SizedBox(
          height: 216,
          child: Center(
            child: Text(
              "Trainingsplan Starten!",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Main()));
  }
}
