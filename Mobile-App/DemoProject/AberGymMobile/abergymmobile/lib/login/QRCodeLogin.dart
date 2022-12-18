// ignore_for_file: library_private_types_in_public_api, file_names, invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:abergymmobile/common/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRCodeLogin extends StatefulWidget {
  const QRCodeLogin({super.key});

  @override
  _QRCodeLoginState createState() => _QRCodeLoginState();
}

class _QRCodeLoginState extends State<QRCodeLogin> {
  bool _showScanRect = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? qrCardId;
  QRViewController? controller;
  String name = "";
  final Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);
  final Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  bool _shouldNavigate = false;
  late Timer _timer;
  bool _showGestureDetector = false;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() async {
    var status = await Permission.camera.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      var result = await Permission.camera.request();
      if (result != PermissionStatus.granted) {
        requestPermission();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_shouldNavigate) {
      return SplashScreen(name);
    }

    _timer = Timer(const Duration(seconds: 10), () {
      if (_showScanRect == true) {
        setState(() {
          _showGestureDetector = true;
        });
      }
      _timer.cancel();
    });

    return Scaffold(
      backgroundColor: darkgrey,
      appBar: AppBar(
        title: Text(
          'Scanne den QR Code',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: lightblue,
          ),
        ),
        backgroundColor: const Color.fromRGBO(37, 37, 50, 1),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(
            Icons.cancel,
            color: lightblue,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !_showScanRect
              ? AlertDialog(
                  title: const Text(
                    'Wie loggen Sie sich ein?',
                    textAlign: TextAlign.center,
                  ),
                  content: Image.asset('assets/images/qrcode.gif'),
                  actions: [
                    GestureDetector(
                      child: Center(
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 42, 195, 255),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'OK',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _showScanRect = true;
                        });
                      },
                    ),
                  ],
                )
              : SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                ),
          if (_showGestureDetector == true) ...[
            GestureDetector(
              onTap: () {
                SystemNavigator.pop();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 25),
                child: Text(
                  'Sie können den Code nicht scannen? Beenden Sie die App und starten Sie sie neu.',
                  style: TextStyle(color: lightblue, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrCardId = scanData;
        getWorkoutPlan(qrCardId?.code);
      });
    });
  }

  Future<void> getWorkoutPlan(String? qrCardId) async {
    IResultSet result;

    final conn = await MySQLConnection.createConnection(
      host: '192.168.8.153',
      port: 3306,
      userName: 'root',
      password: 'abergymmobile_kp',
      databaseName: 'AberGymMobileDb',
    );

    await conn.connect();
    result = await conn
        .execute("select p.card_id, p.first_name, p.last_name from Person p");

    for (final row in result.rows) {
      setState(
        () {
          String? firstName = "";
          String? lastName = "";
          if (qrCardId == row.colAt(0)) {
            firstName = row.colAt(1);
            lastName = row.colAt(2);
            name = "$firstName $lastName";
          }
        },
      );
    }
    if (name.isEmpty == false) {
      setState(() {
        _shouldNavigate = true;
      });
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('key', name);
    await conn.close();
  }

  @override
  void dispose() {
    _timer.cancel();
    controller?.dispose();
    super.dispose();
  }
}
