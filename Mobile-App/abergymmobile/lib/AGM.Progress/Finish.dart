// ignore_for_file: use_build_context_synchronously, no_logic_in_create_state, must_be_immutable, file_names

import 'package:abergymmobile/AGM.Animations/FadeAnimation.dart';
import 'package:abergymmobile/AGM.Feedback/Feedback.dart';
import 'package:abergymmobile/AGM.Home/Layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinishWorkout extends StatefulWidget {
  late int amountrows;
  FinishWorkout({super.key, required this.amountrows});

  @override
  State<FinishWorkout> createState() => _FinishWorkoutState(amountrows);
}

class _FinishWorkoutState extends State<FinishWorkout> {
  final Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  int amountrows = 0;
  _FinishWorkoutState(this.amountrows);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeAnimation(
          1.2,
          Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 100),
            child: Text(
              "Sie haben Ihren Trainingsplan erfolgreich abegschlossen!",
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        FadeAnimation(
          1.2,
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Text(
              "Wollen Sie diesem Trainingsplan noch Feedback geben?",
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5.0),
          child: FadeAnimation(
            1.3,
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      for (int i = 0; i < amountrows; i++) {
                        prefs.remove('finishedExcersice_$i');
                      }
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          child: const FeedbackForm(),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          "Ja",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      for (int i = 0; i < amountrows; i++) {
                        prefs.remove('finishedExcersice_$i');
                      }
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          child: const Layout(),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          "Nein",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
