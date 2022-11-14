// ignore_for_file: must_be_immutable, no_logic_in_create_state, file_names, prefer_typing_uninitialized_variables

import 'package:abergymmobile/CommonBase/AppBar.dart';
import 'package:abergymmobile/ProgressSystem/PSTable.dart';
import 'package:flutter/material.dart';

class PSSystem extends StatefulWidget {
  String? ename;
  String? wereps;
  String? wesets;
  String? weweight;
  int i;
  List<bool> finished;

  PSSystem(
      {super.key,
      required this.ename,
      required this.wereps,
      required this.wesets,
      required this.weweight,
      required this.i,
      required this.finished});
  @override
  State<PSSystem> createState() =>
      _PSSystemState(ename, wereps, wesets, weweight, i, finished);
}

class _PSSystemState extends State<PSSystem> {
  ///Constructor
  String? ename;
  String? wereps;
  String? wesets;
  String? weweight;
  int i;
  List<bool> finished;
  _PSSystemState(
    this.ename,
    this.wereps,
    this.wesets,
    this.weweight,
    this.i,
    this.finished,
  );

  ///Variables
  ///
  ///Widget-Variables
  Color fontColor = const Color.fromARGB(255, 42, 195, 255);
  Color backgroundColor = const Color.fromRGBO(37, 37, 50, 1);
  double? fontSizeRows = 13;
  double? fontPixelsRows = 1.5;

  ///Data-Variables
  int counter = 0;

  void _increaseCounter() {
    setState(() => counter++);
    if (counter > int.parse(wesets!)) {
      setState(() => finished[i] = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
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
            child: Column(
              children: [
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
                  child: Table(
                    children: [
                      TableRow(
                        children: [
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
                            child: Text(
                              'Kg: ${weweight.toString()}',
                              textScaleFactor: fontPixelsRows,
                              style: TextStyle(
                                fontSize: fontSizeRows,
                                color: fontColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: _increaseCounter,
            child: Container(
              padding: const EdgeInsets.only(top: 65),
              margin: const EdgeInsets.all(50.0),
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                color: fontColor,
                shape: BoxShape.circle,
              ),
              child: counter <= int.parse(wesets!)
                  ? Column(
                      children: [
                        Text(
                          '$counter/$wesets',
                          style: TextStyle(
                            color: backgroundColor,
                            fontSize: 100,
                          ),
                        ),
                        Text(
                          "Erledigte Sätze",
                          style: TextStyle(
                            color: backgroundColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PSTable(
                                  finished: finished,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Übung",
                                style: TextStyle(
                                  color: backgroundColor,
                                  fontSize: 75,
                                ),
                              ),
                              Text(
                                "Fertig",
                                style: TextStyle(
                                  color: backgroundColor,
                                  fontSize: 65,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 111,
        child: Center(
          child: finished[i]
              ? const Text(
                  "Bitte auf den Bildschirm drücken, um eine neue Übung auzuwählen",
                  style: TextStyle(
                    color: Color.fromARGB(255, 46, 109, 136),
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                )
              : const Text(
                  "Bitte auf den Bildschirm drücken, um einen neuen Satz zu starten",
                  style: TextStyle(
                    color: Color.fromARGB(255, 46, 109, 136),
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
