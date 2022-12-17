// ignore_for_file: file_names, library_private_types_in_public_api

//Test
import 'package:abergymmobile/main.dart';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mysql_client/mysql_client.dart';

class QRCodeLogin extends StatefulWidget {
  const QRCodeLogin({super.key});

  @override
  _QRCodeLoginState createState() => _QRCodeLoginState();
}

class _QRCodeLoginState extends State<QRCodeLogin> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? qrCardId;
  late QRViewController controller;
  String name = "";
  final Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);
  final Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  bool _shouldNavigate = false;
  bool _enableCamera = false;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    if (_shouldNavigate) {
      return const MyApp();
    }
    return Scaffold(
      backgroundColor: darkgrey,
      body: Column(
        children: [
          if (_enableCamera == true) ...[
            Expanded(
              flex: 4,
              child: _buildQrView(context),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
    );
  }

  void requestPermission() async {
    var status = await Permission.camera.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      var result = await Permission.camera.request();
      if (result != PermissionStatus.granted) {
        requestPermission();
      }
    }
    if (status.isGranted == true) {
      setState(() {
        _enableCamera = true;
      });
    }
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
    await conn.close();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
