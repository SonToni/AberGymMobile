import 'package:flutter/material.dart';
import 'package:abergymmobile/mainscreen/table.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WorkoutPlanTable(version: 1),
        bottomNavigationBar: GestureDetector(
          child: Container(
              color: const Color.fromRGBO(37, 37, 50, 1),
              height: 163,
              width: 325,
              child: const Center(
                child: Text(
                  "Trainingsplan Starten!",
                  style: TextStyle(color: Colors.white70, fontSize: 20),
                ),
              )),
          onTap: () {
            print('clicky');
          },
        ));
  }
}
