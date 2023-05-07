// ignore_for_file: file_names, use_build_context_synchronously

import 'package:abergymmobile/AGM.Animations/FadeAnimation.dart';
import 'package:abergymmobile/AGM.Progress/Finish.dart';
import 'package:abergymmobile/AGM.Progress/SetCounter.dart';
import 'package:abergymmobile/AGM.Update/UpdateExcersice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  late String wname = "";
  late List<String> wereps = [];
  late List<String> wesets = [];
  late List<String> weweight = [];
  late List<String> ename = [];
  late int amountrows = 0;
  final Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  final Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);
  List<bool> finishedExcersiceList = [];
  int counter = 0;
  bool finished = false;

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    wname = prefs.getString('wname')!;
    wereps = prefs.getStringList('wereps')!;
    wesets = prefs.getStringList('wesets')!;
    weweight = prefs.getStringList('weweight')!;
    ename = prefs.getStringList('ename')!;
    amountrows = prefs.getInt('amountrows')!;

    for (int i = 0; i < amountrows; i++) {
      if (prefs.get('finishedExcersice_$i') == true) {
        finishedExcersiceList.add(true);
        setState(() {
          counter++;
        });
      } else {
        finishedExcersiceList.add(false);
      }
    }
    if (counter == amountrows) {
      setState(() {
        finished = true;
      });
    }
    setState(() {
      wname = wname;
      wereps = wereps;
      wesets = wesets;
      wesets = wesets;
      weweight = weweight;
      ename = ename;
      amountrows = amountrows;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            colors: [
              Colors.lightBlue[900]!,
              Colors.lightBlue[800]!,
              Colors.lightBlue[400]!,
            ],
          ),
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                height: 70,
                child: Text(
                  wname,
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    if (finished == false) ...[
                      for (int i = 0; i < amountrows; i++) ...[
                        if (finishedExcersiceList[i] == false) ...[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: SetCounter(
                                    index: i,
                                  ),
                                ),
                              );
                            },
                            onLongPress: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: UpdateExcersice(index: i),
                                ),
                              );
                              getData();
                            },
                            child: toDoListItem(
                              i,
                              false,
                            ),
                          ),
                        ]
                      ],
                      for (int i = 0; i < amountrows; i++) ...[
                        if (finishedExcersiceList[i] == true) ...[
                          FadeAnimation(
                            0.5,
                            toDoListItem(
                              i,
                              true,
                            ),
                          ),
                        ],
                      ]
                    ] else ...[
                      FinishWorkout(amountrows: amountrows),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container toDoListItem(int i, bool isFinished) {
    return Container(
      height: 78,
      margin: const EdgeInsets.only(
        top: 3.8,
        right: 12,
        left: 12,
        bottom: 3.8,
      ),
      decoration: isFinished
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color.fromARGB(255, 25, 68, 85),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: lightblue,
            ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              (ename.isNotEmpty ? ename[i].toString() : ""),
              textScaleFactor: 2,
              style: isFinished
                  ? GoogleFonts.montserrat(
                      fontSize: 11,
                      color: darkgrey,
                      fontWeight: FontWeight.bold,
                    )
                  : GoogleFonts.montserrat(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              textAlign: TextAlign.center,
            ),
          ),
          Table(
            children: [
              TableRow(
                children: [
                  Center(
                    child: Text(
                      (wesets.isNotEmpty
                          ? 'Sätze: ${wesets[i].toString()}'
                          : ""),
                      textScaleFactor: 1.5,
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        color: darkgrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      (wereps.isNotEmpty ? 'Wdh: ${wereps[i].toString()}' : ""),
                      textScaleFactor: 1.5,
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        color: darkgrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      (weweight.isNotEmpty
                          ? 'Kg: ${weweight[i].toString()}'
                          : ""),
                      textScaleFactor: 1.5,
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        color: darkgrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
