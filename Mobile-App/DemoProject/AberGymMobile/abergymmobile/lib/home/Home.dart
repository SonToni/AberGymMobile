import 'package:abergymmobile/home/bodies/HomeBody.dart';
import 'package:abergymmobile/home/bodies/SecondBody.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 1;
  Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);
  final screens = [SecondBody(), HomeBody()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
            backgroundColor: darkgrey,
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
