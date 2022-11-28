// ignore_for_file: must_be_immutable, no_logic_in_create_state, file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class WorkoutPlanTable extends StatefulWidget {
  int version = 0;
  WorkoutPlanTable({super.key, required this.version});

  @override
  State<WorkoutPlanTable> createState() => _WorkoutPlanTableState(version);
}

class _WorkoutPlanTableState extends State<WorkoutPlanTable> {
  ///Constructor
  int version = 0;
  _WorkoutPlanTableState(this.version);

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

  Future<void> getWorkoutPlan() async {
    ///Variables
    ///
    ///Data-Variables
    ///SelectResult
    var result;

    ///Create Connection
    final conn = await MySQLConnection.createConnection(
      //host: '192.168.8.153',
      host: '172.17.215.173',
      //host: '172.28.224.1',
      port: 3306,
      userName: 'root',
      password: 'abergymmobile_kp',
      databaseName: 'AberGymDb', // optional,
    );

    ///Connect
    await conn.connect();

    ///Query
    ///
    ///Version == 1 -> 'Heutiger Trainingsplan'
    ///Version == 0 -> 'Letzter Trainingsplan'
    if (version == 1) {
      result = await conn.execute(
          "select w.name, e.name as excersice, we.`sets`, we.weight, we.reps from Workoutplan w join WorkoutExercise we on we.workoutplan_id = w.id join Exercise e on we.exercise_id = e.id where w.id = (select max(id) from Workoutplan)");
    } else if (version == 2) {
      result = await conn.execute(
          "select w.name, e.name as excersice, we.`sets`, we.weight, we.reps from Workoutplan w join WorkoutExercise we on we.workoutplan_id = w.id join Exercise e on we.exercise_id = e.id where w.id = (select max(id)-1 from Workoutplan)");
    }

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
  Color fontColor = const Color.fromARGB(255, 42, 195, 255);
  Color backgroundColor = const Color.fromRGBO(37, 37, 50, 1);
  double? fontSizeRows = 13;
  double? fontPixelsRows = 1.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Angemeldet als: Peric Antonio',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 42, 195, 255), // Farbe anpassen
          ),
        ),
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (version == 2) ...[
            Image.asset('assets/images/AdBanner.png'),
          ],
          /*Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 5,
              ),
              child: Text(
                "Angemeldet als: Peric Antonio",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: fontColor,
                ),
              ),
            ),
          ),*/
          Container(
            padding: const EdgeInsets.all(8),
            height: 80,
            child: Column(
              children: <Widget>[
                if (version == 1) ...[
                  Text(
                    ///Check Variable if null
                    "Ihr Heutiger Trainingsplan:",
                    style: TextStyle(
                      fontSize: 20,
                      color: fontColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text(
                      ///Check Variable if null
                      (wname?.length != null ? wname.toString() : ""),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: fontColor,
                      ),
                    ),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      ///Check Variable if null
                      (wname?.length != null ? wname.toString() : ""),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: fontColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: RawScrollbar(
              thickness: 7,
              thumbVisibility: true,
              trackVisibility: true,
              trackColor: Colors.white70,
              shape: StadiumBorder(
                side: BorderSide(
                  color: fontColor,
                  width: 5.0,
                ),
              ),
              child: ListView(
                children: <Widget>[
                  ///Go through Data
                  for (int i = 0; i < amountrows; i++) ...[
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ///Check Variable if null
                        (ename.isNotEmpty ? ename[i].toString() : ""),
                        textScaleFactor: 2,
                        style: TextStyle(
                          fontSize: fontSizeRows,
                          color: fontColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              Center(
                                child: Text(
                                  ///Check Variable if null
                                  (wesets.isNotEmpty
                                      ? 'Sätze: ${wesets[i].toString()}'
                                      : ""),
                                  textScaleFactor: fontPixelsRows,
                                  style: TextStyle(
                                    fontSize: fontSizeRows,
                                    color: fontColor,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  ///Check Variable if null
                                  (wereps.isNotEmpty
                                      ? 'Wdh: ${wereps[i].toString()}'
                                      : ""),
                                  textScaleFactor: fontPixelsRows,
                                  style: TextStyle(
                                    fontSize: fontSizeRows,
                                    color: fontColor,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  ///Check Variable if null
                                  (weweight.isNotEmpty
                                      ? 'Kg: ${weweight[i].toString()}'
                                      : ""),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
