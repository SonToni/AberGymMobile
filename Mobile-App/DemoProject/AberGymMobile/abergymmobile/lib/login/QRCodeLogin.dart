// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeLogin extends StatefulWidget {
  const QRCodeLogin({super.key});

  @override
  _QRCodeLoginState createState() => _QRCodeLoginState();
}

class _QRCodeLoginState extends State<QRCodeLogin> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? qrText;
  late QRViewController controller;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    /*var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;*/

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              /*overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
              ),*/
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                if (qrText != null)
                  Text(
                    'Data: ${qrText!.code}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
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
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
