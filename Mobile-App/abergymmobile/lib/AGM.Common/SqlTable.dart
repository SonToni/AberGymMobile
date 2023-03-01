// ignore_for_file: file_names, must_be_immutable, no_logic_in_create_state, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SqlTable extends StatefulWidget {
  int version = 0;
  SqlTable({super.key, required this.version});

  @override
  State<SqlTable> createState() => _SqlTableState(version);
}

class _SqlTableState extends State<SqlTable> {
  int version = 0;
  String name = "";
  late String wname = "";
  late List<String> wereps = [];
  late List<String> wesets = [];
  late List<String> weweight = [];
  late List<String> ename = [];
  late int amountrows = 0;
  final Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  final Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);
  double? fontSizeRows = 12;
  double? fontPixelsRows = 1.5;

  _SqlTableState(this.version);

  Future<void> getWorkoutPlan() async {
    var result;
    final conn = await MySQLConnection.createConnection(
      host: '192.168.8.153',
      //host: '172.17.219.81',
      port: 3306,
      userName: 'root',
      password: 'abergymmobile_kp',
      databaseName: 'AberGymDb',
    );
    await conn.connect();

    if (version == 1) {
      result = await conn.execute(
          "select w.name, e.name as excersice, we.`sets`, we.weight, we.reps from Workoutplan w join WorkoutExercise we on we.workoutplan_id = w.id join Exercise e on we.exercise_id = e.id where w.id = (select max(id) from Workoutplan)");
    } else if (version == 0) {
      result = await conn.execute(
          "select w.name, e.name as excersice, we.`sets`, we.weight, we.reps from Workoutplan w join WorkoutExercise we on we.workoutplan_id = w.id join Exercise e on we.exercise_id = e.id where w.id = (select max(id)-1 from Workoutplan)");
    }

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
    if (version == 1) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('wname', wname);
      prefs.setStringList('wereps', wereps);
      prefs.setStringList('wesets', wesets);
      prefs.setStringList('weweight', weweight);
      prefs.setStringList('ename', ename);
      prefs.setInt('amountrows', amountrows);
    }
  }

  void getName() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('key')!;
  }

  @override
  void initState() {
    super.initState();
    getWorkoutPlan().then((value) {});
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.lightBlue[900]!,
              Colors.lightBlue[800]!,
              Colors.lightBlue[400]!,
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Text(
                    name,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (version == 1) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        wname,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ] else if (version == 0) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        wname,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
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
                trackColor: darkgrey.withOpacity(0.3),
                shape: StadiumBorder(
                  side: BorderSide(
                    color: lightblue.withOpacity(0.5),
                    width: 5.0,
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    for (int i = 0; i < amountrows; i++) ...[
                      Divider(
                        thickness: 1,
                        color: darkgrey,
                      ),
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          (ename.isNotEmpty ? ename[i].toString() : ""),
                          textScaleFactor: 2,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: fontSizeRows,
                            fontWeight: FontWeight.bold,
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
                                    (wesets.isNotEmpty
                                        ? 'Sätze: ${wesets[i].toString()}'
                                        : ""),
                                    textScaleFactor: fontPixelsRows,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: fontSizeRows,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    (wereps.isNotEmpty
                                        ? 'Wdh: ${wereps[i].toString()}'
                                        : ""),
                                    textScaleFactor: fontPixelsRows,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: fontSizeRows,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    (weweight.isNotEmpty
                                        ? 'Kg: ${weweight[i].toString()}'
                                        : ""),
                                    textScaleFactor: fontPixelsRows,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: fontSizeRows,
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
      ),
    );
  }
}
