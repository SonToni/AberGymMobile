// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import '../../ProgressSystem/PSMain.dart';
import '../MySqlTable/Table.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key});

  ///Variables
  ///
  ///Wigdet-Variables
  ///ElevatedButton shape
  double shape = 0.0;

  ///ColorConfig
  Color backgroundColor = const Color.fromRGBO(37, 37, 50, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Call up WorkoutPlanTable with version 1
      body: WorkoutPlanTable(version: 1),
      bottomNavigationBar: ElevatedButton(
        onPressed: (() => _navigateToNextScreen(context)),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(shape),
              topLeft: Radius.circular(shape),
            ),
          ),
        ),
        child: const SizedBox(
          height: 195,
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
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const PSMain()));
  }
}
