// ignore_for_file: file_names

import 'package:abergymmobile/ProgressSystem/PSTable.dart';
import 'package:flutter/material.dart';

class PSBody extends StatelessWidget {
  PSBody({super.key});
  List<bool> emptyList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(37, 37, 50, 1),
      //Call up PSTable
      body: PSTable(finished: emptyList),
      bottomNavigationBar: const SizedBox(
        height: 111,
        child: Center(
          child: Text(
            "Übung bitte auswählen!",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
