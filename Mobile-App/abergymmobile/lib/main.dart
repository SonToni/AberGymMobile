import 'package:flutter/material.dart';
import 'CommonBase/AppBar.dart';
import 'StartScreen/Bodies/HomeBody.dart';
import 'StartScreen/Bodies/SecondBody.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const AberGym());
}

class AberGym extends StatefulWidget {
  const AberGym({super.key});

  @override
  State<AberGym> createState() => _AberGymState();
}

class _AberGymState extends State<AberGym> {
  @override
  void initState() {
    super.initState();
  }

  ///Variables
  ///
  ///Data-Variables
  final screens = [const SecondBody(), HomeBody()];
  int currentIndex = 1;

  ///Widget-Variables
  Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  Color backgroundColor = const Color.fromRGBO(37, 37, 50, 1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        ///Call up extern AppBar
        //appBar: const Header(),
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

            ///Update currentIndex when users tap button
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
