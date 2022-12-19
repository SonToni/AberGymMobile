// ignore_for_file: file_names, must_be_immutable

import 'package:abergymmobile/progress/ToDoList.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Body({super.key});
  List<bool> emptyList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(37, 37, 50, 1),
      body: ToDoList(),
    );
  }
}
