import 'package:flutter/material.dart';
import 'package:abergymmobile/mainscreen/testtable.dart';
import 'package:abergymmobile/mainscreen/table.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const WorkoutPlanTable();
    /*const RawScrollbar(
      //Scrollbar für Testen
      isAlwaysShown: true,
      thickness: 10,
      radius: Radius.circular(50),
      thumbColor: Color.fromARGB(255, 157, 217, 241),
      //child: DataTableExample(),
      child: WorkoutPlanTable(),
    );*/
  }
}
