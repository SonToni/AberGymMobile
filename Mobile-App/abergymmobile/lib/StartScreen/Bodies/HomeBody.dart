// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';

//ÄNDERN!
import '../../mainscreen/table.dart';
import '../../progressSystem/psMain.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key});

  ///ElevatedButton shape
  double shape = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///call up WorkoutPlanTable with version 1
      body: WorkoutPlanTable(version: 1),
      bottomNavigationBar: ElevatedButton(
        onPressed: (() => _navigateToNextScreen(context)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(37, 37, 50, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(shape),
              topLeft: Radius.circular(shape),
            ),
          ),
        ),
        child: const SizedBox(
          height: 163,
          width: 500,
          child: Center(
            child: Text(
              "Trainingsplan Starten!",
              style: TextStyle(color: Colors.white70, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    ///navigate to next Page with a Button
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const PSMain()));
  }
}
