// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:abergymmobile/AGM.Progress/ToDoList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetCounter extends StatefulWidget {
  int index = 0;
  SetCounter({super.key, required this.index});

  @override
  State<SetCounter> createState() => _SetCounterState(index);
}

class _SetCounterState extends State<SetCounter> {
  int index = 0;
  late List<String> werepsList = [];
  late List<String> wesetsList = [];
  late List<String> weweightList = [];
  late List<String> enameList = [];
  String wereps = "";
  String wesets = "";
  String weweight = "";
  String ename = "";
  Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);
  int counter = 0;
  late bool finishedExcersice;
  double? fontSizeRows = 13;
  double? fontPixelsRows = 1.5;

  _SetCounterState(this.index);

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    werepsList = prefs.getStringList('wereps')!;
    wesetsList = prefs.getStringList('wesets')!;
    weweightList = prefs.getStringList('weweight')!;
    enameList = prefs.getStringList('ename')!;

    setState(() {
      wereps = werepsList[index];
      wesets = wesetsList[index];
      weweight = weweightList[index];
      ename = enameList[index];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void _increaseCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => counter++);
    if (counter > int.parse(wesets)) {
      finishedExcersice = true;
      prefs.setBool('finishedExcersice_$index', finishedExcersice);
    }
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
      body: Container(
        padding: const EdgeInsets.only(top: 125),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            colors: [
              Colors.lightBlue[200]!,
              Colors.lightBlue[500]!,
              Colors.lightBlue[900]!,
            ],
          ),
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  ename,
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
                    style: GoogleFonts.montserrat(
                      fontSize: fontSizeRows,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                                'Sätze: $wesets',
                                textScaleFactor: fontPixelsRows,
                                style: GoogleFonts.montserrat(
                                  fontSize: fontSizeRows,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Wdh: $wereps',
                                textScaleFactor: fontPixelsRows,
                                style: GoogleFonts.montserrat(
                                  fontSize: fontSizeRows,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Kg: $weweight',
                                textScaleFactor: fontPixelsRows,
                                style: GoogleFonts.montserrat(
                                  fontSize: fontSizeRows,
                                  color: Colors.white,
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
            if (counter <= int.parse(wesets)) ...[
              GestureDetector(
                onTap: _increaseCounter,
                child: Container(
                  padding: const EdgeInsets.only(top: 65),
                  margin: const EdgeInsets.all(50.0),
                  width: 300.0,
                  height: 300.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      colors: [
                        Colors.lightBlue[900]!,
                        Colors.lightBlue[800]!,
                        Colors.lightBlue[400]!,
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$counter/$wesets',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 100,
                        ),
                      ),
                      Text(
                        "Erledigte Sätze",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ToDoList(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 65),
                  margin: const EdgeInsets.all(50.0),
                  width: 300.0,
                  height: 300.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      colors: [
                        Colors.lightBlue[900]!,
                        Colors.lightBlue[800]!,
                        Colors.lightBlue[400]!,
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ToDoList(),
                            ),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Übung",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 70,
                              ),
                            ),
                            Text(
                              "Fertig",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
