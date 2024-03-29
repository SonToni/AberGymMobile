import 'package:abergymmobile/common/AppBar.dart';
import 'package:abergymmobile/home/Home.dart';
import 'package:abergymmobile/login/NFCLogin.dart';
import 'package:abergymmobile/login/QRCodeLogin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  debugDefaultTargetPlatformOverride = null;

  bool alreadylogin = false;
  bool? x;
  final prefs = await SharedPreferences.getInstance();
  x = await prefs.getBool('login');
  if (x == true) {
    alreadylogin = true;
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: alreadylogin ? const Home() : const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);
  final Color lightblue = const Color.fromARGB(255, 42, 195, 255);

  void setStandardColors() async {
    Color _color = Color.fromARGB(255, 42, 195, 255);
    Color _backgroundColor = Color.fromRGBO(37, 37, 50, 1);
    Color _fontColor = Color.fromARGB(255, 255, 255, 255);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('backgroundColor', _backgroundColor.toString());
    prefs.setString('fontColor', _fontColor.toString());
    prefs.setString('color', _color.toString());
    prefs.setBool('blackMode', true);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      backgroundColor: darkgrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Willkommen bei AberGym',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: lightblue,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Bitte wählen Sie eine der folgenden Möglichkeiten zum Einloggen aus:',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 45),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    duration: Duration(milliseconds: 350),
                    child: const QRCodeLogin(),
                  ),
                );
              },
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  color: lightblue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Einloggen per QR-Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NFCLogin(),
                  ),
                );
              },
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  color: lightblue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.nfc,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Einloggen per NFC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
