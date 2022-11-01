import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class WorkoutPlanTable extends StatefulWidget {
  int version = 0;
  WorkoutPlanTable({super.key, required this.version});

  @override
  State<WorkoutPlanTable> createState() => _WorkoutPlanTableState(version);
}

class _WorkoutPlanTableState extends State<WorkoutPlanTable> {
  int version = 0;
  _WorkoutPlanTableState(this.version);

  String? wname;
  late List<String?> wereps = [];
  late List<String?> wesets = [];
  late List<String?> weweight = [];
  late List<String?> ename = [];
  late int amountrows = 0;

  Future<void> getWorkoutplan() async {
    //print("Connecting to mysql server...");

    // create connection
    final conn = await MySQLConnection.createConnection(
      host: '192.168.8.153',
      port: 3306,
      userName: 'root',
      password: 'abergymmobile_kp',
      databaseName: 'AberGymDb', // optional,
    );

    await conn.connect();
    var result;

    //print("Connected");

    // make query

    if (version == 1) {
      result = await conn.execute(
          "select w.name, e.name as excersice, we.`sets`, we.weight, we.reps from Workoutplan w join WorkoutExercise we on we.workoutplan_id = w.id join Exercise e on we.exercise_id = e.id where w.id = (select max(id) from Workoutplan)");
    } else if (version == 2) {
      result = await conn.execute(
          "select w.name, e.name as excersice, we.`sets`, we.weight, we.reps from Workoutplan w join WorkoutExercise we on we.workoutplan_id = w.id join Exercise e on we.exercise_id = e.id where w.id = (select max(id)-1 from Workoutplan)");
    }

    amountrows = result.numOfRows;

    // print query result
    for (final row in result.rows) {
      setState(() {
        wname = row.colAt(0);
        ename.add(row.colAt(1));
        wesets.add(row.colAt(2));
        weweight.add(row.colAt(3));
        wereps.add(row.colAt(4));
      });
    }
    // close all connections
    await conn.close();
  }

  @override
  void initState() {
    super.initState();
    getWorkoutplan();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromRGBO(37, 37, 50, 1),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              height: 60,
              child: Text((wname?.length != null ? wname.toString() : ""),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 42, 195, 255),
                  ),
                  textAlign: TextAlign.center),
            ),
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView(
                  children: <Widget>[
                    for (int i = 0; i < amountrows; i++) ...[
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.white, width: 1.5),
                          ),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text((ename.isNotEmpty ? ename[i].toString() : ""),
                                textScaleFactor: 2,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 42, 195, 255),
                                ),
                                textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Table(
                          children: [
                            TableRow(
                              children: [
                                Center(
                                  child: Text(
                                    (wesets.isNotEmpty
                                        ? 'Sätze: ${wesets[i].toString()}'
                                        : ""),
                                    textScaleFactor: 1.5,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color.fromARGB(255, 42, 195, 255),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    (wereps.isNotEmpty
                                        ? 'Wdh: ${wereps[i].toString()}'
                                        : ""),
                                    textScaleFactor: 1.5,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color.fromARGB(255, 42, 195, 255),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    (weweight.isNotEmpty
                                        ? 'Kg: ${weweight[i].toString()}'
                                        : ""),
                                    textScaleFactor: 1.5,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color.fromARGB(255, 42, 195, 255),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ],
                ),
              ),
            )
          ],
        ),
      );
}
