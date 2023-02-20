--  Exercise

Insert into exercise ( name, muscle_group, description) values ('Skullcrusher', 'Trizeps', 'Lorem ipsum dolor sit amet, consetetur');
Insert into exercise ( name, muscle_group, description) values ('Schulterdrücken', 'Schultern', 'Kurzhanteln');
Insert into exercise ( name, muscle_group, description) values ('Shoulder Raises', 'Schultern', 'Lorem ipsum dolor sit amet, consetetur');
Insert into exercise ( name, muscle_group, description) values ('Wadenheben', 'Waden', 'Lorem ipsum dolor sit amet, consetetur');
Insert into exercise ( name, muscle_group, description) values ('Wadendrücken', 'Waden', 'An der Schiene');
Insert into exercise ( name, muscle_group, description) values ('Beinpresse Eng', 'Beine', 'Beinpresse enger Stand');
Insert into exercise ( name, muscle_group, description) values ('Beinstrecker', 'Beine', 'An der Maschine');
Insert into exercise ( name, muscle_group, description) values ('Beinbeuger', 'Beine', 'An der Maschine');
Insert into exercise ( name, muscle_group, description) values ('Bankdrücken', 'Brust', 'Lorem ipsum dolor sit amet, consetetur');
Insert into exercise ( name, muscle_group, description) values ('Schiefes Bankdrücken', 'Brust', 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.');
Insert into exercise ( name, muscle_group, description) values ('Flys von unter', 'Brust', 'Kabelzug mit Griffen');
Insert into exercise ( name, muscle_group, description) values ('Legraises', 'Bauch', 'Hängend an der Klimzugstange');
Insert into exercise ( name, muscle_group, description) values ('Eindrehen', 'Bauch', 'Am Kabelturm mit dem Strick');
Insert into exercise ( name, muscle_group, description) values ('T-Bar row', 'Rücken', 'An der Maschine mit breiten Elbogen');
Insert into exercise ( name, muscle_group, description) values ('Rudern Langhantel', 'Rücken', 'Lorem ipsum dolor sit amet, consetetur');
Insert into exercise ( name, muscle_group, description) values ('Hammer Curls', 'Bizeps', 'Kurzhantel wie einen Hammer halten und anheben');
Insert into exercise ( name, muscle_group, description) values ('Curls Kabelturm', 'Bizeps', 'Langer gerader Griff am Turm unten befestigen');
Insert into exercise ( name, muscle_group, description) values ('Armstrecker Strick', 'Trizeps', 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.');

Insert into exercise ( name, muscle_group, description) values ('Ueberkopfstrecken Strick', 'Trizeps', 'Lorem ipsum dolor sit amet, consetetur');
Insert into exercise ( name, muscle_group, description) values ('Überzüge Strick', 'Rücken', 'Am Kabel oder Maschine langsame wiederholungen');

--------------------------------------------------------
--  First Customer | Test data
--------------------------------------------------------
Insert into Person (first_name,last_name,email) values ('Antonio','Peric','test@gmail.com');
Insert into Trainee (id) values (1);
Insert into Person (first_name,last_name,email) values ('Valentin','Duerk','du@gmail.com');
Insert into Trainee (id) values (2);
Insert into Person (first_name,last_name,email) values ('Mattias','Wunder','wunder@gmail.com');
Insert into Trainee (id) values (3);
Insert into Person (first_name,last_name,email) values ('Antonio','Kuvac','kumail@gmail.com');
Insert into Trainee (id) values (4);

--------------------------------------------------------
--  First Workoutplan
--------------------------------------------------------

Insert into Workoutplan (name,trainee_id) values ('Ganzkörper Workout', 1);

-- WorkoutExercise

Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (5,0.0,50,1,1);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (3,100.0,6,1,2);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (3,20.0,25,1,3);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (3,32.5,15,1,4);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (5,12.5,15,1,5);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (5,80.5,20,1,6);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (2,80.0,20,1,7);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (4,30.0,20,1,8);

--------------------------------------------------------
--  Second Workoutplan
--------------------------------------------------------

Insert into Workoutplan (name,trainee_id) values ('Ganzkörper Workout', 1);

-- WorkoutExercise

Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (5,10,50,2,1);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (3,100.0,6,2,2);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (3,20.0,25,2,3);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (3,32.5,15,2,4);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (5,12.5,15,2,5);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (5,80.5,20,2,6);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (2,80.0,20,2,7);
Insert into WorkoutExercise (sets,weight,reps,workoutplan_id, exercise_id) values (4,30.0,20,2,8);