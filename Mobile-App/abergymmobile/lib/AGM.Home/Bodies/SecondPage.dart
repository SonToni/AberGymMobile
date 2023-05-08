// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutData {
  final String name;
  final int sets;
  final int reps;
  final double weight;
  final String exercise_name;

  WorkoutData({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.exercise_name,
  });

  factory WorkoutData.fromMap(Map<String, dynamic> map) {
    return WorkoutData(
      name: map['name'] as String,
      sets: map['sets'] as int,
      reps: map['reps'] as int,
      weight: map['weight'] as double,
      exercise_name: map['exercise_name'] as String,
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Set<String> workoutNames = {};
  late List<WorkoutData> workoutData = [];
  String name = "";
  final Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  final Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);

  Future<void> getData() async {
    final conn = await MySQLConnection.createConnection(
      host: '192.168.0.5',
      //host: '172.18.48.1',
      port: 3306,
      userName: 'root',
      password: 'abergymmobile_kp',
      databaseName: 'AberGymDb',
    );
    await conn.connect();

    final result = await conn.execute(
      'SELECT wp.name, we.`sets`, we.reps, we.weight, e.name as exercise_name '
      'FROM Workoutplan wp '
      'JOIN WorkoutExercise we ON wp.id = we.workoutplan_id '
      'JOIN Exercise e ON we.exercise_id = e.id '
      'WHERE wp.id NOT IN (SELECT MAX(id) FROM Workoutplan)',
    );

    for (final row in result.rows) {
      final workout = WorkoutData.fromMap({
        'name': row.colAt(0).toString(),
        'sets': int.parse(row.colAt(1).toString()),
        'reps': int.parse(row.colAt(2).toString()),
        'weight': double.parse(row.colAt(3).toString()),
        'exercise_name': row.colAt(4).toString(),
      });
      workoutData.add(workout);
      workoutNames.add(workout.name);
    }
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      workoutData = workoutData;
      name = prefs.getString('key')!;
    });

    await conn.close();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 8),
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
        child: workoutData.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Text(
                    name,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Alte Trainingspläne:",
                    style: GoogleFonts.montserrat(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                      child: ListView.builder(
                        itemCount: workoutNames.length,
                        itemBuilder: (context, index) {
                          final name = workoutNames.elementAt(index);
                          final exercises = workoutData
                              .where((data) => data.name == name)
                              .toList();

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: lightblue,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                minimumSize: const Size(double.infinity, 60),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => Dialog(
                                    backgroundColor: const Color(0xff020227),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              300,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  name,
                                                  style: const TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            Expanded(
                                              child: Scrollbar(
                                                thumbVisibility: true,
                                                child: ListView.builder(
                                                  itemCount: exercises.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final exercise =
                                                        exercises[index];
                                                    return ListTile(
                                                      title: Text(
                                                        exercise.exercise_name,
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        'Sätze: ${exercise.sets}, Wdh: ${exercise.reps}, Kg: ${exercise.weight}',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                name,
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
