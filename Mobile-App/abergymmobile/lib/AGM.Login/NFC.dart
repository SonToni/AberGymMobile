import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFC extends StatefulWidget {
  const NFC({super.key});

  @override
  State<NFC> createState() => _NFCState();
}

class _NFCState extends State<NFC> {
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
      backgroundColor: darkgrey,
      body: Container(
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
        child: _nfcEnabled
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bitte halten Sie Ihre Fitnesskarte zum Handy, um die Karte zu scannen!",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
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
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}
