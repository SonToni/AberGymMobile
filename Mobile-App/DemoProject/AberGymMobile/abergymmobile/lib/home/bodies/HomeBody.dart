// ignore_for_file: must_be_immutable, file_names

import 'package:abergymmobile/common/SqlTable.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key});

  double shape = 0.0;
  Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SqlTable(version: 1),
      /*bottomNavigationBar: ElevatedButton(
        onPressed: (() => _navigateToNextScreen(context)),
        style: ElevatedButton.styleFrom(
          backgroundColor: darkgrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(shape),
              topLeft: Radius.circular(shape),
            ),
          ),
        ),
        child: const SizedBox(
          height: 216,
          child: Center(
            child: Text(
              "Trainingsplan Starten!",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),*/
    );
  }

  /*void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        //PSMain() statt HomeBody
        .push(MaterialPageRoute(builder: (context) => HomeBody()));
  }*/
}
