// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:abergymmobile/common/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCLogin extends StatefulWidget {
  const NFCLogin({super.key});

  @override
  _NFCLoginState createState() => _NFCLoginState();
}

class _NFCLoginState extends State<NFCLogin> {
  bool _nfcEnabled = false;
  ValueNotifier<dynamic> result = ValueNotifier(null);
  final Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);
  final Color lightblue = const Color.fromARGB(255, 42, 195, 255);

  @override
  void initState() {
    super.initState();
    _checkNfcStatus();
  }

  void _checkNfcStatus() async {
    bool nfcEnabled = await NfcManager.instance.isAvailable();
    setState(() {
      _nfcEnabled = nfcEnabled;
    });
  }

  void _startScan() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      NfcManager.instance.stopSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkgrey,
      appBar: const Header(),
      body: Container(
        child: _nfcEnabled
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bitte halten Sie Ihre Fitnesskarte zum Handy, um die Karte zu scannen!",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: lightblue,
                    ),
                  ),
                  GestureDetector(
                    onTap: _startScan,
                    child: const Text("Karte scannen"),
                  ),
                  if (result.value != null) ...[Text(result.value)]
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bitte schalten Sie NFC ein, um die Karte zu scannen!",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: lightblue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}
