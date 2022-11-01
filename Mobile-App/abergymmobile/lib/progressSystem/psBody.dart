// ignore_for_file: file_names

import 'package:abergymmobile/progressSystem/psTable.dart';
import 'package:flutter/material.dart';

class PSBody extends StatelessWidget {
  const PSBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(37, 37, 50, 1),
      body: PSTable(),
      bottomNavigationBar: SizedBox(
        height: 111,
        child: Center(
          child: Text(
            "Übung bitte auswählen!",
            style: TextStyle(color: Colors.white70, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
