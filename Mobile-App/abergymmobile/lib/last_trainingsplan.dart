import 'package:flutter/material.dart';
import 'package:abergymmobile/table.dart';

class Last_Plan extends StatelessWidget {
  const Last_Plan({super.key});

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      //Scrollbar für Testen
      isAlwaysShown: true,
      thickness: 10,
      radius: const Radius.circular(50),
      thumbColor: const Color.fromARGB(255, 157, 217, 241),
      //Scrollbar für Testen
      child: DataTableExample(), //Farbe anpassen
    );
  }
}
