// ignore_for_file: must_be_immutable

import 'package:abergymmobile/update/UpdateBody.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateExcersice extends StatefulWidget {
  int index = 0;
  UpdateExcersice({super.key, required this.index});

  @override
  State<UpdateExcersice> createState() => _UpdateExcersiceState(index);
}

class _UpdateExcersiceState extends State<UpdateExcersice> {
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
  String _sets = '';
  String _reps = '';
  String _kg = '';
  final setsController = TextEditingController();
  final repsController = TextEditingController();
  final kgController = TextEditingController();

  _UpdateExcersiceState(this.index);

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
      setsController.text = wesets;
      repsController.text = wereps;
      kgController.text = weweight;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void _saveInput() {
    setState(() {
      _sets = setsController.text;
      _reps = repsController.text;
      _kg = kgController.text;
    });
  }

  Future<void> saveInputInCache() async {
    if (_sets.isNotEmpty || _kg.isNotEmpty || _reps.isNotEmpty) {
      final conn = await MySQLConnection.createConnection(
        host: '192.168.8.153',
        //host: '172.17.209.169',
        port: 3306,
        userName: 'root',
        password: 'abergymmobile_kp',
        databaseName: 'AberGymMobileDb',
      );

      await conn.connect();
      await conn.execute(
        'UPDATE WorkoutExercise we JOIN Exercise e ON we.exercise_id = e.id SET we.`sets` = :sets, we.weight = :kg, we.reps = :reps WHERE e.name = :name AND we.workoutplan_id = (SELECT MAX(id) FROM Workoutplan)',
        {"sets": _sets, "kg": _kg, "reps": _reps, "name": ename},
      );
      wesetsList[index] = _sets;
      weweightList[index] = _kg;
      werepsList[index] = _reps;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('wesets', wesetsList);
      await prefs.setStringList('weweight', weweightList);
      await prefs.setStringList('wereps', werepsList);

      conn.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkgrey,
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Änderungen bitte Eingeben:",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: lightblue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 15.0, top: 50),
              child: Text(
                'Name: $ename',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: lightblue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Textfeld 1
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: lightblue)),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Sets',
                  labelStyle: TextStyle(
                    color: lightblue,
                    fontSize: 24,
                  ),
                ),
                controller: setsController,
                onChanged: (value) {
                  _saveInput();
                },
                onTap: () {
                  setsController.clear();
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // Textfeld 2
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: lightblue)),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Wiederholungen',
                  labelStyle: TextStyle(
                    color: lightblue,
                    fontSize: 24,
                  ),
                ),
                controller: repsController,
                onChanged: (value) {
                  _saveInput();
                },
                onTap: () {
                  repsController.clear();
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // Textfeld 3
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: lightblue)),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Kg',
                  labelStyle: TextStyle(
                    color: lightblue,
                    fontSize: 24,
                  ),
                ),
                controller: kgController,
                onChanged: (value) {
                  _saveInput();
                },
                onTap: () {
                  kgController.clear();
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await saveInputInCache();
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    duration: Duration(milliseconds: 350),
                    child: UpdateBody(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 50),
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  color: lightblue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Weiter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
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
