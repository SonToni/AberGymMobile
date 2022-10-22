--------------------------------------------------------
--  First Customer | Test data
--------------------------------------------------------
Insert into Person (first_name,last_name,email) values ('Antonio','Peric','test@gmail.com');
Insert into Trainee (id) values (1);

--  Workoutplan

Insert into Workoutplan (name,trainee_id) values ('Ganzkörper Workout', 1);

--  Exercise

Insert into Exercise (name) values ('Liegestütze');
Insert into Exercise (name) values ('Bankdrücken');
Insert into Exercise (name) values ('Cable Flys');
Insert into Exercise (name) values ('Incline Dumbell press');
Insert into Exercise (name) values ('Biceps Curls');
Insert into Exercise (name) values ('Triceps Extension');

-- WorkoutExercise

Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (5,0.0,50,1,1);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (3,100.0,6,1,2);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (3,20.0,25,1,3);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (3,32.5,15,1,4);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (5,12.5,15,1,5);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (5,80.5,20,1,6);