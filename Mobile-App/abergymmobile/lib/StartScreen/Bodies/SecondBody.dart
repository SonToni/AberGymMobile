// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../MySqlTable/Table.dart';

class SecondBody extends StatelessWidget {
  const SecondBody({super.key});

  @override
  Widget build(BuildContext context) {
    ///Call up WorkoutPlanTable with version 2
    return WorkoutPlanTable(version: 2);
  }
}
