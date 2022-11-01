import 'package:flutter/material.dart';
import 'mainscreen/bodies/secondBody.dart';
import 'mainscreen/bodies/homeBody.dart';

void main() => runApp(const MainScreen());

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 1;
  final screens = [const SecondBody(), const HomeBody()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: const Color.fromRGBO(37, 37, 50, 1),
            appBar: AppBar(
              // Navigation
              title: const Text(
                'AberGym',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 42, 195, 255), // Farbe anpassen
                ),
              ),
              backgroundColor: const Color.fromRGBO(37, 37, 50, 1),
              centerTitle: true,
            ),
            body: screens[currentIndex],
            bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(color: Colors.white60, width: 3.0))),
                child: BottomNavigationBar(
                    currentIndex: currentIndex,
                    onTap: (index) => setState(() => currentIndex = index),
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: const Color.fromRGBO(37, 37, 50, 1),
                    selectedItemColor: const Color.fromARGB(
                        255, 42, 195, 255), // Farbe anpassen,
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
                      )
                    ]))));
  }
}
