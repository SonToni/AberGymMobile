import 'dart:ffi';

class Workoutplan {
  late final String wname;
  late final Int wereps;
  late final Int wesets;
  late final Double weweight;
  late final String ename;

  Workoutplan(this.wname, this.ename, this.wesets, this.weweight, this.wereps);
}
