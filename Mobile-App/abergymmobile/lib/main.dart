import 'package:abergymmobile/last_trainingsplan.dart';
import 'package:flutter/material.dart';
import 'package:abergymmobile/table.dart';

void main() => runApp(const AberGymMobile());

class AberGymMobile extends StatelessWidget {
  const AberGymMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'AberGym', home: Home());
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const Body(),
      bottomNavigationBar: const Footer(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      //Scrollbar für Testen
      isAlwaysShown: true,
      thickness: 10,
      radius: const Radius.circular(50),
      thumbColor: const Color.fromARGB(255, 157, 217, 241),
      //Scrollbar für Testen
      child: DataTableExample(), //Farbe anpassen
    );
  }
}

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int currentIndex = 1;
  final screens = [const Home(), const Last_Plan()];

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        backgroundColor: const Color.fromRGBO(37, 37, 50, 1),
        selectedItemColor:
            const Color.fromARGB(255, 42, 195, 255), // Farbe anpassen,
        unselectedItemColor: Colors.white60,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 0),
            label: 'Letzter Trainingsplan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 0),
            label: 'Heutiger Trainingsplan',
          )
        ],
      );
}
