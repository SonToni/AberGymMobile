// ignore_for_file: must_be_immutable, no_logic_in_create_state, file_names, prefer_typing_uninitialized_variables

import 'package:abergymmobile/CommonBase/AppBar.dart';
import 'package:flutter/material.dart';

class PSSystem extends StatefulWidget {
  String? ename;
  String? wereps;
  String? wesets;
  String? weweight;

  PSSystem(
      {super.key,
      required this.ename,
      required this.wereps,
      required this.wesets,
      required this.weweight});
  @override
  State<PSSystem> createState() =>
      _PSSystemState(ename, wereps, wesets, weweight);
}

class _PSSystemState extends State<PSSystem> {
  ///Constructor
  String? ename;
  String? wereps;
  String? wesets;
  String? weweight;

  _PSSystemState(this.ename, this.wereps, this.wesets, this.weweight);

  ///Variables
  ///
  ///Widget-Vairables
  ///ColorConfig
  Color fontColor = const Color.fromARGB(255, 42, 195, 255);
  Color backgroundColor = const Color.fromRGBO(37, 37, 50, 1);
  double? fontSizeRows = 13;
  double? fontPixelsRows = 1.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      backgroundColor: backgroundColor,
      body: Column(children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              ///Check Variable if null
              (ename?.length != null ? 'Übung: ${ename.toString()}' : ""),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: fontColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white,
                  width: 1.5,
                ),
                bottom: BorderSide(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Text(
                "Info",
                textScaleFactor: 2,
                style: TextStyle(
                  fontSize: fontSizeRows,
                  color: fontColor,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Table(children: [
                    TableRow(children: [
                      Center(
                        child: Text(
                          'Sätze: ${wesets.toString()}',
                          textScaleFactor: fontPixelsRows,
                          style: TextStyle(
                            fontSize: fontSizeRows,
                            color: fontColor,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Wdh: ${wereps.toString()}',
                          textScaleFactor: fontPixelsRows,
                          style: TextStyle(
                            fontSize: fontSizeRows,
                            color: fontColor,
                          ),
                        ),
                      ),
                      Center(
                          child: Text('Kg: ${weweight.toString()}',
                              textScaleFactor: fontPixelsRows,
                              style: TextStyle(
                                fontSize: fontSizeRows,
                                color: fontColor,
                              )))
                    ])
                  ]))
            ]))
      ]),
      bottomNavigationBar: SizedBox(
        height: 111,
        child: Center(
          child: Text(
            "Bitte auf den Bildschirm drücken, um einen neuen Satz zu starten",
            style: TextStyle(
              color: fontColor,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
