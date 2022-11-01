// ignore_for_file: file_names

import 'package:flutter/material.dart';

//ÄNDERN!
import '../../mainscreen/table.dart';

class SecondBody extends StatelessWidget {
  const SecondBody({super.key});

  @override
  Widget build(BuildContext context) {
    ///call up WorkoutPlanTable with version 2
    return WorkoutPlanTable(version: 2);
  }
}
