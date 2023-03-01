// ignore_for_file: file_names

import 'package:abergymmobile/AGM.Home/Bodies/HomePage.dart';
import 'package:abergymmobile/AGM.Home/Bodies/SecondPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final bodies = [const SecondPage(), const HomePage()];
  int currentIndex = 1;
  Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodies[currentIndex],
      bottomNavigationBar: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: GNav(
              curve: Curves.easeOutSine,
              color: darkgrey,
              gap: 8,
              iconSize: 25,
              activeColor: lightblue,
              tabBackgroundColor: darkgrey.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              duration: const Duration(milliseconds: 500),
              tabs: [
                GButton(
                  icon: Icons.fitness_center,
                  text: "Letzter Trainingsplan",
                  textStyle: GoogleFonts.montserrat(
                    color: lightblue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GButton(
                  icon: Icons.fitness_center,
                  text: "Heutiger Trainingsplan",
                  textStyle: GoogleFonts.montserrat(
                    color: lightblue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              selectedIndex: currentIndex,
              onTabChange: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 2,
              color: darkgrey,
            ),
          ),
        ],
      ),
    );
  }
}
