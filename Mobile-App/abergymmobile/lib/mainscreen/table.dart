import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class WorkoutPlanTable extends StatefulWidget {
  const WorkoutPlanTable({super.key});

  @override
  State<WorkoutPlanTable> createState() => _WorkoutPlanTableState();
}

class _WorkoutPlanTableState extends State<WorkoutPlanTable> {
  String? wname;
  late List<String?> wereps = [];
  late List<String?> wesets = [];
  late List<String?> weweight = [];
  late List<String?> ename = [];

  Future<void> getWorkoutplan() async {
    print("Connecting to mysql server...");

    // create connection
    final conn = await MySQLConnection.createConnection(
      host: '192.168.8.153',
      port: 3306,
      userName: 'root',
      password: 'abergymmobile_kp',
      databaseName: 'AberGymDb', // optional,
    );

    await conn.connect();

    print("Connected");

    // make query
    var result = await conn.execute(
        "select w.name, e.name as excersice, we.`sets`, we.weight, we.reps from Workoutplan w join WorkoutExercise we on we.workoutplan_id = w.id join Exercise e on we.exercise_id = e.id");

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
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromRGBO(37, 37, 50, 1),
        body: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  (wname?.length != null ? wname.toString() : ""),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 42, 195, 255)),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                (ename.isNotEmpty ? ename[0].toString() : ""),
                textScaleFactor: 2,
                style: const TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 42, 195, 255)),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  children: [
                    TableRow(children: [
                      Center(
                          child: Text(
                        (wesets.isNotEmpty
                            ? 'Sätze: ${wesets[0].toString()}'
                            : ""),
                        textScaleFactor: 1.5,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 42, 195, 255)),
                      )),
                      Center(
                          child: Text(
                        (wereps.isNotEmpty
                            ? 'Wdh: ${wereps[0].toString()}'
                            : ""),
                        textScaleFactor: 1.5,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 42, 195, 255)),
                      )),
                      Center(
                        child: Text(
                          (weweight.isNotEmpty
                              ? 'Kg: ${weweight[0].toString()}'
                              : ""),
                          textScaleFactor: 1.5,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 42, 195, 255)),
                        ),
                      )
                    ])
                  ],
                ))
          ],
        ),
        //TestButtom
        floatingActionButton: FloatingActionButton(onPressed: getWorkoutplan),
      );
}
