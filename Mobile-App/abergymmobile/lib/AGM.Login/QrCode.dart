// ignore_for_file: file_names, use_build_context_synchronously

import 'package:abergymmobile/AGM.Common/WelcomeSplash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key? key}) : super(key: key);

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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'AberGym',
          style: GoogleFonts.montserrat(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
                    title: Text(
                      'Wie loggen Sie sich ein?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont('Montserrat'),
                    ),
                    content: Image.asset('assets/images/qrcode.gif'),
                    actions: [
                      GestureDetector(
                        child: Center(
                          child: Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              color: lightblue,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Okay',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
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
                : Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _buildQrView(context),
                        if (isLoading)
                          CircularProgressIndicator(
                            color: lightblue,
                          ),
                      ],
                    ),
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
        isLoading = true;
        checkUser(result?.code);
      });
    });
  }

  Future<void> checkUser(String? qrCardId) async {
    IResultSet result;
    final conn = await MySQLConnection.createConnection(
      host: '192.168.8.153',
      //host: '172.18.48.1',
      port: 3306,
      userName: 'root',
      password: 'abergymmobile_kp',
      databaseName: 'AberGymDb',
    );

    await conn.connect();
    result = await conn.execute(
      "SELECT first_name, last_name FROM Person WHERE card_id = :card_id",
      {"card_id": qrCardId},
    );

    for (final row in result.rows) {
      setState(() {
        String? firstName = "";
        String? lastName = "";
        firstName = row.colAt(0);
        lastName = row.colAt(1);
        name = "$firstName $lastName";
      });
    }
    final prefs = await SharedPreferences.getInstance();
    if (name.isNotEmpty) {
      setState(() {
        logintrue = true;
        prefs.setBool('login', logintrue);
        prefs.setString('key', name);
      });
      isLoading = false;
      controller?.pauseCamera();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => WelcomeSplashPage(name)));
    } else {
      isLoading = false;
    }

    await conn.close();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
