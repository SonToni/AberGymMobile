import 'package:abergymmobile/logic/models/workoutplan.dart';
import 'package:abergymmobile/logic/mysql.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class WorkoutPlanTable extends StatefulWidget {
  const WorkoutPlanTable({super.key});

  @override
  State<WorkoutPlanTable> createState() => _WorkoutPlanTableState();
}

class _WorkoutPlanTableState extends State<WorkoutPlanTable> {
  //Test
  final pool = MySQLConnectionPool(
    host: '192.168.8.153',
    port: 3306,
    userName: 'root',
    password: 'abergymmobile_kp',
    maxConnections: 10,
    databaseName: 'AberGymDb',
  );

  List<Workoutplan> result = [];
  var wname = '';
  void getWorkoutPlan() async {
    var result = await pool.execute("SELECT * FROM WorkoutPlan");
    for (final row in result.rows) {
      print(row.assoc());
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Workoutplan:'),
              Text(wname.toString())
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: getWorkoutPlan),
      );
}

/*
select w.name, e.name, we.`sets`, we.weight, we.reps
from AberGymDb.Workoutplan w
inner join AberGymDb.WorkoutExercise we 
on we.workoutplan_id = w.id
inner join AberGymDb.Exercise e 
on we.exercise_id = e.id
 */
