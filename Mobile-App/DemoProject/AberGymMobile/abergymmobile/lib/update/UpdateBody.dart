// ignore_for_file: must_be_immutable, file_names

import 'package:abergymmobile/home/Home.dart';
import 'package:abergymmobile/update/UpdateList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateBody extends StatefulWidget {
  UpdateBody({super.key});

  @override
  State<UpdateBody> createState() => _UpdateBodyState();
}

class _UpdateBodyState extends State<UpdateBody> {
  double shape = 0.0;
  int amountrows = 0;
  Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    amountrows = await prefs.getInt('amountrows')!;

    setState(() {
      amountrows = amountrows;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpdateList(),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          for (int i = 0; i < amountrows; i++) {
            prefs.remove('finishedExcersice_$i');
          }
          _navigateToNextScreen(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: darkgrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(shape),
              topLeft: Radius.circular(shape),
            ),
          ),
        ),
        child: SizedBox(
          height: 152,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Trainingsplan speichern",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.arrow_right_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Home()));
  }
}
