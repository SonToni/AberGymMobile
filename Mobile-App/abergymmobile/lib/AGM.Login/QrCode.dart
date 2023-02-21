// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
//delete
import '../main.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({super.key});

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  final Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);
  final Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  bool showScanRect = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool logintrue = false;
  String name = "";
  bool _shouldNavigate = false;

  @override
  Widget build(BuildContext context) {
    if (_shouldNavigate) {
      return const LoginPage();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'AberGym',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.lightBlue[900]!,
              Colors.lightBlue[800]!,
              Colors.lightBlue[400]!,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !showScanRect
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
                            showScanRect = true;
                          });
                        },
                      ),
                    ],
                  )
                : SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: _buildQrView(context),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 250.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: lightblue,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        checkUser(result?.code);
      });
    });
  }

  Future<void> checkUser(String? qrCardId) async {
    IResultSet result;

    final conn = await MySQLConnection.createConnection(
      host: '192.168.8.153',
      port: 3306,
      userName: 'root',
      password: 'abergymmobile_kp',
      databaseName: 'AberGymDb',
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
    final prefs = await SharedPreferences.getInstance();
    if (name.isEmpty == false) {
      setState(() {
        _shouldNavigate = true;
        logintrue = true;
        prefs.setBool('login', logintrue);
      });
    }
    prefs.setString('key', name);
    await conn.close();
  }
}
