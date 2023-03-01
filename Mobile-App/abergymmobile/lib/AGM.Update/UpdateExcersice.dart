// ignore_for_file: file_names, must_be_immutable, no_logic_in_create_state, use_build_context_synchronously

import 'package:abergymmobile/AGM.Common/SqlTable.dart';
import 'package:abergymmobile/AGM.Progress/LayoutTDL.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    werepsList = prefs.getStringList('wereps')!;
    wesetsList = prefs.getStringList('wesets')!;
    weweightList = prefs.getStringList('weweight')!;
    enameList = prefs.getStringList('ename')!;

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
        databaseName: 'AberGymDb',
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

      await prefs.remove('wesets');
      await prefs.remove('weweight');
      await prefs.remove('wereps');

      await prefs.setStringList('wesets', wesetsList);
      await prefs.setStringList('weweight', weweightList);
      await prefs.setStringList('wereps', werepsList);

      conn.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'AberGym',
          style: GoogleFonts.montserrat(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 110),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            colors: [
              Colors.lightBlue[200]!,
              Colors.lightBlue[500]!,
              Colors.lightBlue[900]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Änderungen bitte Eingeben:",
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 15.0, top: 25),
                child: Text(
                  'Übung: $ename',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Textfeld 1
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.white),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Sätze',
                    labelStyle: GoogleFonts.montserrat(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Textfeld 2
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.white),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Wiederholungen',
                    labelStyle: GoogleFonts.montserrat(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Textfeld 3
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.white),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Kg',
                    labelStyle: GoogleFonts.montserrat(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await saveInputInCache();
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      child: const LayoutTDL(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 25),
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[900]!,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Speichern',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
