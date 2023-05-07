// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:abergymmobile/AGM.Home/Bodies/StatisticPage.dart';
import 'package:flutter/material.dart';
import 'package:abergymmobile/AGM.Home/Bodies/SecondPage.dart';
import 'package:abergymmobile/AGM.Home/Bodies/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final bodies = [const SecondPage(), const HomePage(), const StatisticPage()];
  int currentIndex = 1;
  Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodies[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        backgroundColor: Colors.lightBlue[400]!,
        color: Colors.white,
        buttonBackgroundColor: lightblue,
        height: 60,
        items: <Widget>[
          _buildCurvedButton(Icons.history, ""),
          _buildCurvedButton(Icons.fitness_center, ""),
          _buildCurvedButton(Icons.show_chart, ""),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildCurvedButton(IconData icon, String text) {
    /*return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: darkgrey,
        ),
        Text(
          text,
          style: GoogleFonts.montserrat(
            color: darkgrey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );*/
    return Icon(
      icon,
      color: darkgrey,
    );
  }
}
