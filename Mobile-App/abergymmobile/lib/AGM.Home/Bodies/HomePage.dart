// ignore_for_file: file_names, must_be_immutable, use_build_context_synchronously

import 'package:abergymmobile/AGM.Animations/FadeAnimation.dart';
import 'package:abergymmobile/AGM.Common/SqlTable.dart';
import 'package:abergymmobile/AGM.Progress/LayoutTDL.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);
    return Scaffold(
      extendBody: true,
      body: SqlTable(version: 1),
      bottomNavigationBar: FadeAnimation(
        0.3,
        ElevatedButton(
          onPressed: (() async {
            final prefs = await SharedPreferences.getInstance();
            int? amountrows = prefs.getInt('amountrows');
            int countTrue = 0;

            if (amountrows != null) {
              for (int i = 0; i < amountrows; i++) {
                if (prefs.getBool('finishedExcersice_$i') == true) {
                  countTrue++;
                }
              }
              if (countTrue == amountrows) {
                for (int i = 0; i < amountrows; i++) {
                  prefs.remove('finishedExcersice_$i');
                }
              }
            }

            _navigateToNextScreen(context);
          }),
          style: ElevatedButton.styleFrom(
            backgroundColor: darkgrey.withOpacity(0.8),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(0.0),
                topLeft: Radius.circular(0.0),
              ),
            ),
          ),
          child: SizedBox(
            height: 216,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Trainingsplan Starten!",
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_rounded,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "(Knopf drücken!)",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                  ),
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
        .push(MaterialPageRoute(builder: (context) => const LayoutTDL()));
  }
}
