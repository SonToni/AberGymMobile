import 'package:flutter/material.dart';
import 'CommonBase/AppBar.dart';
import 'StartScreen/Bodies/HomeBody.dart';
import 'StartScreen/Bodies/SecondBody.dart';

void main() {
  runApp(const AberGym());
}

class AberGym extends StatefulWidget {
  const AberGym({super.key});

  @override
  State<AberGym> createState() => _AberGymState();
}

class _AberGymState extends State<AberGym> {
  ///Navigation Bar Methods
  ///currentIndex = 1 to start with HomeBody
  ///0|1
  final screens = [const SecondBody(), HomeBody()];
  int currentIndex = 1;

  ///Colors-Config
  Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  Color backgroundColor = const Color.fromRGBO(37, 37, 50, 1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        ///call up extern AppBar
        appBar: const Header(),
        body: screens[currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: lightblue,
                width: 3.0,
              ),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: backgroundColor,
            selectedItemColor: lightblue,
            unselectedItemColor: Colors.white60,
            selectedFontSize: 18,
            unselectedFontSize: 18,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 0),
                label: 'Letzter Trainingsplan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 0),
                label: 'Heutiger Trainingsplan',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
