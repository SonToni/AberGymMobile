// ignore_for_file: file_names, prefer_typing_uninitialized_variables, must_be_immutable, no_logic_in_create_state

import 'package:abergymmobile/ProgressSystem/PSSetCounter.dart';
import 'package:abergymmobile/StartScreen/Bodies/HomeBody.dart';
import 'package:abergymmobile/UpdateSystem/USStart.dart';
import 'package:abergymmobile/main.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class PSTable extends StatefulWidget {
  List<bool> finished;
  PSTable({
    super.key,
    required this.finished,
  });

  @override
  State<PSTable> createState() => _PSTableState(finished);
}

class _PSTableState extends State<PSTable> {
  ///Variables
  ///
  ///Data-Variables
  ///WorkoutPlan
  String? wname;
  late List<String?> wereps = [];
  late List<String?> wesets = [];
  late List<String?> weweight = [];
  late List<String?> ename = [];
  late int amountrows = 0;
  List<bool> finishedExcersiceList = [];

  _PSTableState(this.finishedExcersiceList);

  bool watchBoolList = false;

  Future<void> getWorkoutPlan() async {
    ///Variables
    ///
    ///Data-Variables
    ///SelectResult
    var result;

    ///Create Connection
    final conn = await MySQLConnection.createConnection(
      //host: '192.168.8.153',
      host: '172.17.210.49',
      //host: '172.28.224.1',
      port: 3306,
      userName: 'root',
      password: 'abergymmobile_kp',
      databaseName: 'AberGymDb', // optional,
    );

    ///Connect
    await conn.connect();

    ///Query
    result = await conn.execute(
        "select w.name, e.name as excersice, we.`sets`, we.weight, we.reps from Workoutplan w join WorkoutExercise we on we.workoutplan_id = w.id join Exercise e on we.exercise_id = e.id where w.id = (select max(id) from Workoutplan)");

    ///Get RowAmount
    amountrows = result.numOfRows;

    ///Save Data
    for (final row in result.rows) {
      setState(
        () {
          wname = row.colAt(0);
          ename.add(row.colAt(1));
          wesets.add(row.colAt(2));
          weweight.add(row.colAt(3));
          wereps.add(row.colAt(4));
        },
      );
    }
    if (finishedExcersiceList.isEmpty == true) {
      for (int i = 0; i < amountrows; i++) {
        finishedExcersiceList.add(false);
      }
    }
    int counter = 0;
    for (int i = 0; i < amountrows; i++) {
      if (finishedExcersiceList[i] == true) {
        counter++;
      }
      if (counter == amountrows) {
        watchBoolList = true;
      }
    }

    ///Close Connection
    await conn.close();
  }

  ///Start Widget with new Data
  @override
  void initState() {
    super.initState();
    getWorkoutPlan().then((value) {});
  }

  ///Variables
  ///
  ///Widget-Vairables
  Color fontColor = const Color.fromRGBO(37, 37, 50, 1);
  Color backgroundColor = const Color.fromRGBO(37, 37, 50, 1);
  double? fontSizeRows = 13;
  double? fontPixelsRows = 1.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            height: 70,
            child: Text(
              ///Check Variable if null
              (wname?.length != null ? wname.toString() : ""),
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 42, 195, 255),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: RawScrollbar(
              thickness: 7,
              thumbVisibility: true,
              trackVisibility: true,
              trackColor: Colors.white70,
              shape: const StadiumBorder(
                side: BorderSide(
                  color: Color.fromARGB(255, 42, 195, 255),
                  width: 5.0,
                ),
              ),
              child: ListView(
                children: <Widget>[
                  ///Go through Data
                  if (watchBoolList == true) ...[
                    InkWell(
                      onTap: () {
                        AlertDialog alertDialog = AlertDialog(
                          backgroundColor:
                              const Color.fromARGB(255, 60, 60, 75),
                          title: const Text('Workout ändern?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              )),
                          content: const Text(
                              'Wollen Sie an diesen Workoutplan Änderungen vornehmen?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AberGym()),
                                );
                              },
                              child: const Text('Nein',
                                  style: TextStyle(fontSize: 20)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const USStart()),
                                );
                              },
                              child: const Text('Ja',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alertDialog;
                          },
                        );
                      },
                      child: Container(
                        height: 500,
                        child: const Center(
                          child: Text(
                            "Sie Haben Ihren Trainingsplan erfolgreich abgeschlossen",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    for (int i = 0; i < amountrows; i++) ...[
                      if (finishedExcersiceList.isEmpty == true) ...[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PSSystem(
                                  ename: ename[i],
                                  wereps: wereps[i],
                                  wesets: wesets[i],
                                  weweight: weweight[i],
                                  i: i,
                                  finished: finishedExcersiceList,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 78,
                            margin: const EdgeInsets.only(
                              top: 3.8,
                              right: 12,
                              left: 12,
                              bottom: 3.8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color.fromARGB(255, 42, 195, 255),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ///Check Variable if null
                                    (ename.isNotEmpty
                                        ? ename[i].toString()
                                        : ""),
                                    textScaleFactor: 2,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: fontColor,
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
                                            ///Check Variable if null
                                            (wesets.isNotEmpty
                                                ? 'Sätze: ${wesets[i].toString()}'
                                                : ""),
                                            textScaleFactor: 1.5,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: fontColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            ///Check Variable if null
                                            (wereps.isNotEmpty
                                                ? 'Wdh: ${wereps[i].toString()}'
                                                : ""),
                                            textScaleFactor: 1.5,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: fontColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            ///Check Variable if null
                                            (weweight.isNotEmpty
                                                ? 'Kg: ${weweight[i].toString()}'
                                                : ""),
                                            textScaleFactor: 1.5,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: fontColor,
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
                          ),
                        ),
                      ] else ...[
                        if (finishedExcersiceList[i] == false) ...[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PSSystem(
                                    ename: ename[i],
                                    wereps: wereps[i],
                                    wesets: wesets[i],
                                    weweight: weweight[i],
                                    i: i,
                                    finished: finishedExcersiceList,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 78,
                              margin: const EdgeInsets.only(
                                top: 3.8,
                                right: 12,
                                left: 12,
                                bottom: 3.8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: const Color.fromARGB(255, 42, 195, 255),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      ///Check Variable if null
                                      (ename.isNotEmpty
                                          ? ename[i].toString()
                                          : ""),
                                      textScaleFactor: 2,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: fontColor,
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
                                              ///Check Variable if null
                                              (wesets.isNotEmpty
                                                  ? 'Sätze: ${wesets[i].toString()}'
                                                  : ""),
                                              textScaleFactor: 1.5,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: fontColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              ///Check Variable if null
                                              (wereps.isNotEmpty
                                                  ? 'Wdh: ${wereps[i].toString()}'
                                                  : ""),
                                              textScaleFactor: 1.5,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: fontColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              ///Check Variable if null
                                              (weweight.isNotEmpty
                                                  ? 'Kg: ${weweight[i].toString()}'
                                                  : ""),
                                              textScaleFactor: 1.5,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: fontColor,
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
                            ),
                          ),
                        ] else if (finishedExcersiceList[i] == true) ...[
                          Container(
                            height: 78,
                            margin: const EdgeInsets.only(
                              top: 3.8,
                              right: 12,
                              left: 12,
                              bottom: 3.8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color.fromARGB(255, 54, 88, 101),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ///Check Variable if null
                                    (ename.isNotEmpty
                                        ? ename[i].toString()
                                        : ""),
                                    textScaleFactor: 2,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: fontColor,
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
                                            ///Check Variable if null
                                            (wesets.isNotEmpty
                                                ? 'Sätze: ${wesets[i].toString()}'
                                                : ""),
                                            textScaleFactor: 1.5,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: fontColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            ///Check Variable if null
                                            (wereps.isNotEmpty
                                                ? 'Wdh: ${wereps[i].toString()}'
                                                : ""),
                                            textScaleFactor: 1.5,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: fontColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            ///Check Variable if null
                                            (weweight.isNotEmpty
                                                ? 'Kg: ${weweight[i].toString()}'
                                                : ""),
                                            textScaleFactor: 1.5,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: fontColor,
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
                          ),
                        ]
                      ],
                    ],
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 111,
        child: Center(
            child: watchBoolList
                ? const Text(
                    "Bitte auf den Bildschirm drücken um fortzufahren!",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  )
                : const Text(
                    "Übung bitte auswählen!",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  )),
      ),
    );
  }
}
