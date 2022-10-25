import 'package:abergymmobile/logic/mysql.dart';
import 'package:flutter/material.dart';

class WorkoutPlanTable extends StatefulWidget {
  const WorkoutPlanTable({super.key});

  @override
  State<WorkoutPlanTable> createState() => _WorkoutPlanTableState();
}

class _WorkoutPlanTableState extends State<WorkoutPlanTable> {
  var db = MySql();
  var w_name = '';
  var we_reps = '';
  var we_sets = '';
  var we_weight = '';
  var e_name = '';

  void _getWorkout() {
    db.getConnection().then((conn) async {
      String sql = 'select name from AberGymDb.Workoutplan';
      //select w.name, we.reps, we.`sets`, we.weight, e.name from AberGymDb.Workoutplan w inner join AberGymDb.WorkoutExercise we on we.workoutplan_id = w.id inner join AberGymDb.Exercise e on we.exercise_id = e.id

      var results = await conn.query(sql);
      for (var row in results) {
        print('Name: ${row[0]}, email: ${row[1]}');
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[const Text('Workoutplan:'), Text(w_name)],
          ),
        ), //Test
        floatingActionButton: FloatingActionButton(
          onPressed: _getWorkout,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}

/*
select w.name, we.reps, we.`sets`, we.weight, e.name
from AberGymDb.Workoutplan w
inner join AberGymDb.WorkoutExercise we 
on we.workoutplan_id = w.id
inner join AberGymDb.Exercise e 
on we.exercise_id = e.id
 */
