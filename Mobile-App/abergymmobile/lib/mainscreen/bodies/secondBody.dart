import 'package:flutter/material.dart';
import 'package:abergymmobile/mainscreen/table.dart';

class SecondBody extends StatelessWidget {
  const SecondBody({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutPlanTable(version: 2);
  }
}
