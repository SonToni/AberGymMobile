import 'package:abergymmobile/AGM.Animations/FadeAnimation.dart';
import 'package:abergymmobile/AGM.Login/NFC.dart';
import 'package:abergymmobile/AGM.Login/QrCode.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  debugDefaultTargetPlatformOverride = null;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));
}

class Login extends StatelessWidget {
  Login({super.key});

  final Color lightBlue900 = Colors.lightBlue[900]!;
  final Color lightBlue800 = Colors.lightBlue[800]!;
  final Color lightBlue400 = Colors.lightBlue[400]!;
  final Color whiteColor = Colors.white;
  final TextStyle montserratBold = GoogleFonts.montserrat(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  final TextStyle montserratNormal = GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: 23,
  );
  final double sizedBoxHeight = 20.0;

  Widget _buildGestureDetector(
      String title, IconData icon, Widget page, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: whiteColor,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: montserratBold,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [lightBlue900, lightBlue800, lightBlue400],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Row(
                      children: <Widget>[
                        Text(
                          "AberGym",
                          style: GoogleFonts.montserrat(
                            color: whiteColor,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.fitness_center,
                          color: Colors.white,
                          size: 50,
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.black,
                              blurRadius: 20.0,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeAnimation(
                    1.3,
                    Text(
                      "Willkommen zurück!",
                      style: montserratNormal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: sizedBoxHeight),
            Expanded(
              child: FadeAnimation(
                1.4,
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 60,
                          ),
                          FadeAnimation(
                            1.5,
                            Text(
                              'Login-Möglichkeiten:',
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: sizedBoxHeight),
                          FadeAnimation(
                            1.6,
                            _buildGestureDetector(
                              "Einloggen per QR-Code",
                              Icons.camera_alt,
                              const QRCodePage(),
                              context,
                            ),
                          ),
                          SizedBox(height: sizedBoxHeight),
                          FadeAnimation(
                            1.7,
                            _buildGestureDetector(
                              "Einloggen per NFC",
                              Icons.nfc,
                              const NFC(),
                              context,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
