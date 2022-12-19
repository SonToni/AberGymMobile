// ignore_for_file: must_be_immutable

import 'package:abergymmobile/common/AppBar.dart';
import 'package:abergymmobile/progress/ToDoList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetCounter extends StatefulWidget {
  int index;
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
    werepsList = await prefs.getStringList('wereps')!;
    wesetsList = await prefs.getStringList('wesets')!;
    weweightList = await prefs.getStringList('weweight')!;
    enameList = await prefs.getStringList('ename')!;

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
      setState(() async {
        finishedExcersice = true;
        prefs.setBool('finishedExcersice_$index', finishedExcersice);
        bool test = await prefs.getBool('finishedExcersice_$index')!;
        print('$finishedExcersice $index $test');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkgrey,
      appBar: Header(),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                ename,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: lightblue,
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
                    color: lightblue,
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
                              style: TextStyle(
                                fontSize: fontSizeRows,
                                color: lightblue,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Wdh: $wereps',
                              textScaleFactor: fontPixelsRows,
                              style: TextStyle(
                                fontSize: fontSizeRows,
                                color: lightblue,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Kg: $weweight',
                              textScaleFactor: fontPixelsRows,
                              style: TextStyle(
                                fontSize: fontSizeRows,
                                color: lightblue,
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
          GestureDetector(
            onTap: _increaseCounter,
            child: Container(
              padding: const EdgeInsets.only(top: 65),
              margin: const EdgeInsets.all(50.0),
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                color: lightblue,
                shape: BoxShape.circle,
              ),
              child: counter <= int.parse(wesets)
                  ? Column(
                      children: [
                        Text(
                          '$counter/$wesets',
                          style: TextStyle(
                            color: darkgrey,
                            fontSize: 100,
                          ),
                        ),
                        Text(
                          "Erledigte Sätze",
                          style: TextStyle(
                            color: darkgrey,
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
                                builder: (context) => ToDoList(),
                              ),
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Übung",
                                style: TextStyle(
                                  color: darkgrey,
                                  fontSize: 75,
                                ),
                              ),
                              Text(
                                "Fertig",
                                style: TextStyle(
                                  color: darkgrey,
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
    );
  }
}
