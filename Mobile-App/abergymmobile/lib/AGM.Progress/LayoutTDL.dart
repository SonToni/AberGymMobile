// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

import 'package:abergymmobile/AGM.Home/Layout.dart';
import 'package:abergymmobile/AGM.Progress/ToDoList.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LayoutTDL extends StatelessWidget {
  const LayoutTDL({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 60, 60, 75),
              title: const Text('Sind Sie sich sicher?',
                  style: TextStyle(color: Colors.white)),
              content: const Text('Wollen Sie das Workout beenden?',
                  style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Nein'),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      PageTransition(
                          child: const Layout(),
                          type: PageTransitionType.fade)),
                  child: const Text('Ja'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: const Scaffold(
        backgroundColor: Color.fromRGBO(37, 37, 50, 1),
        body: ToDoList(),
      ),
    );
  }
}
