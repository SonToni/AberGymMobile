// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class PSTable extends StatefulWidget {
  const PSTable({super.key});

  @override
  State<PSTable> createState() => _PSTableState();
}

class _PSTableState extends State<PSTable> {
  String? wname;
  late List<String?> wereps = [];
  late List<String?> wesets = [];
  late List<String?> weweight = [];
  late List<String?> ename = [];
  late int amountrows = 0;

  @override
  void initState() {
    super.initState();
    getWorkoutplan();
  }

  Future<void> getWorkoutplan() async {
    //print("Connecting to mysql server...");

    // create connection
    final conn = await MySQLConnection.createConnection(
      host: '192.168.8.153',
      port: 3306,
      userName: 'root',
      password: 'abergymmobile_kp',
      databaseName: 'AberGymDb',
    );

    await conn.connect();
    var result = await conn.execute(
        "select w.name, e.name as excersice, we.`sets`, we.weight, we.reps from Workoutplan w join WorkoutExercise we on we.workoutplan_id = w.id join Exercise e on we.exercise_id = e.id where w.id = (select max(id) from Workoutplan)");
    amountrows = result.numOfRows;

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
    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(37, 37, 50, 1),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30.0),
              height: 100,
              child: Text((wname?.length != null ? wname.toString() : ""),
                  style: const TextStyle(
                    fontSize: 35,
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
                                (ename.isNotEmpty ? ename[i].toString() : ""),
                                textScaleFactor: 2,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center),
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
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color.fromRGBO(37, 37, 50, 1),
                                        fontWeight: FontWeight.bold,
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
                                        color: Color.fromRGBO(37, 37, 50, 1),
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
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color.fromRGBO(37, 37, 50, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ],
              ),
            )),
          ],
        ));
  }
}
