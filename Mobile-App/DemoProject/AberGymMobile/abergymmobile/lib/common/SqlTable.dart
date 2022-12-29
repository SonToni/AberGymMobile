// ignore_for_file: must_be_immutable, invalid_use_of_visible_for_testing_member

import 'package:abergymmobile/common/Settings.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SqlTable extends StatefulWidget {
  int version = 0;

  SqlTable({super.key, required this.version});

  @override
  State<SqlTable> createState() => _SqlTableState(version);
}

class _SqlTableState extends State<SqlTable> {
  Color? _color = null;
  Color? _backgroundColor = null;
  Color? _fontColor = null;
  double? fontSizeRows = 13;
  double? fontPixelsRows = 1.5;
  int version = 0;
  String name = "";
  late String wname = "";
  late List<String> wereps = [];
  late List<String> wesets = [];
  late List<String> weweight = [];
  late List<String> ename = [];
  late int amountrows = 0;

  _SqlTableState(this.version);

  Future<void> getWorkoutPlan() async {
    var result;

    final conn = await MySQLConnection.createConnection(
      host: '192.168.8.153',
      //host: '172.17.209.169',
      port: 3306,
      userName: 'root',
      password: 'abergymmobile_kp',
      databaseName: 'AberGymMobileDb',
    );

    await conn.connect();

    //Select anpassen an user!!!!!!!!!
    if (version == 1) {
      result = await conn.execute(
          "select w.name, e.name as excersice, we.`sets`, we.weight, we.reps from Workoutplan w join WorkoutExercise we on we.workoutplan_id = w.id join Exercise e on we.exercise_id = e.id where w.id = (select max(id) from Workoutplan)");
    } else if (version == 2) {
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

  void getColors() async {
    final prefs = await SharedPreferences.getInstance();

    String backgroundColor = await prefs.getString('backgroundColor')!;
    String fontColor = await prefs.getString('fontColor')!;
    String color = await prefs.getString('color')!;
    setState(() {
      _backgroundColor = Color(int.parse(backgroundColor.substring(6, 16)));
      _fontColor = Color(int.parse(fontColor.substring(6, 16)));
      _color = Color(int.parse(color.substring(6, 16)));
    });
  }

  @override
  void initState() {
    super.initState();
    getWorkoutPlan().then((value) {});
    getName();
    getColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _color,
          ),
        ),
        backgroundColor: _backgroundColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 80,
            child: Column(
              children: <Widget>[
                if (version == 1) ...[
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text(
                      wname,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: _color,
                      ),
                    ),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text(
                      wname,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: _color,
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
                  //color: _color!,
                  width: 5.0,
                ),
              ),
              child: ListView(
                children: <Widget>[
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
                        (ename.isNotEmpty ? ename[i].toString() : ""),
                        textScaleFactor: 2,
                        style: TextStyle(
                          fontSize: fontSizeRows,
                          color: _color,
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
                                  style: TextStyle(
                                    fontSize: fontSizeRows,
                                    color: _color,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  (wereps.isNotEmpty
                                      ? 'Wdh: ${wereps[i].toString()}'
                                      : ""),
                                  textScaleFactor: fontPixelsRows,
                                  style: TextStyle(
                                    fontSize: fontSizeRows,
                                    color: _color,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  (weweight.isNotEmpty
                                      ? 'Kg: ${weweight[i].toString()}'
                                      : ""),
                                  textScaleFactor: fontPixelsRows,
                                  style: TextStyle(
                                    fontSize: fontSizeRows,
                                    color: _color,
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

  @override
  void dispose() {
    super.dispose();
  }
}
