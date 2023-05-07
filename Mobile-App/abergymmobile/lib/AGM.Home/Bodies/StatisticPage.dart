// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mysql_client/mysql_client.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  late List<String> ename = [];
  late String selectedEname = "";
  final Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  final Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);
  List<DateTime> dates = [];
  List<double> weights = [];
  String name = "";

  void getData() async {
    if (selectedEname.isEmpty) {
      final prefs = await SharedPreferences.getInstance();
      ename = await getExerciseNames();
      setState(() {
        name = prefs.getString('key')!;
        selectedEname = ename[0];
      });
    }
    final conn = await MySQLConnection.createConnection(
      host: '192.168.8.153',
      //host: '172.18.48.1',
      port: 3306,
      userName: 'root',
      password: 'abergymmobile_kp',
      databaseName: 'AberGymDb',
    );
    await conn.connect();

    var result = await conn.execute(
        'SELECT wp.created_date, we.weight FROM Workoutplan wp JOIN WorkoutExercise we ON wp.id = we.workoutplan_id JOIN Exercise e ON we.exercise_id = e.id WHERE e.name = :name',
        {"name": selectedEname});

    for (final row in result.rows) {
      String dateString = row.colAt(0).toString();
      DateTime date = DateTime.parse(dateString);
      setState(() {
        dates.add(date);
        weights.add(double.parse(row.colAt(1).toString()));
      });
    }

    await conn.close();
  }

  Future<List<String>> getExerciseNames() async {
    final conn = await MySQLConnection.createConnection(
      host: '192.168.8.153',
      //host: '172.18.48.1',
      port: 3306,
      userName: 'root',
      password: 'abergymmobile_kp',
      databaseName: 'AberGymDb',
    );
    await conn.connect();

    var result = await conn.execute('SELECT name FROM Exercise');

    for (final row in result.rows) {
      String name = row.colByName('name') as String;
      ename.add(name);
    }

    await conn.close();

    return ename;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<FlSpot> generateChartData(List<DateTime> dates, List<double> weights) {
    List<FlSpot> chartData = [];
    for (int i = 0; i < dates.length; i++) {
      chartData
          .add(FlSpot(dates[i].millisecondsSinceEpoch.toDouble(), weights[i]));
    }
    return chartData;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    if (dates
        .map((date) => date.millisecondsSinceEpoch.toDouble())
        .contains(value)) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
      String text = '${date.day}.${date.month}';

      return Container(
        margin: const EdgeInsets.all(3.5),
        child: SizedBox(
          height: 40,
          child: Transform.rotate(
            angle: pi / 4,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                text,
                style: style,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    if (weights.contains(value)) {
      String text = value.toInt().toString();

      return FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          "$text kg",
          style: style,
          textAlign: TextAlign.center,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              name,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Übung Bitte auswählen: ',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 15),
                DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: lightblue,
                  iconEnabledColor: Colors.white,
                  underline: Container(
                    height: 1,
                    color: Colors.white,
                  ),
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  value: selectedEname,
                  items: ename.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) async {
                    setState(() {
                      selectedEname = newValue!;
                    });
                    dates.clear();
                    weights.clear();
                    getData();
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Statistik:',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color(0xff020227),
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 35,
                    height: MediaQuery.of(context).size.height - 300,
                    child: dates.isNotEmpty && weights.isNotEmpty
                        ? LineChart(
                            LineChartData(
                              lineTouchData: LineTouchData(
                                touchTooltipData: LineTouchTooltipData(
                                  tooltipBgColor:
                                      Colors.blueGrey.withOpacity(0.8),
                                  fitInsideHorizontally: true,
                                  fitInsideVertically: true,
                                  getTooltipItems:
                                      (List<LineBarSpot> lineBarsSpot) {
                                    return lineBarsSpot.map((lineBarSpot) {
                                      final date =
                                          DateTime.fromMillisecondsSinceEpoch(
                                        lineBarSpot.x.toInt(),
                                      );
                                      return LineTooltipItem(
                                        '${date.day}.${date.month}.${date.year}\n${lineBarSpot.y} kg',
                                        GoogleFonts.montserrat(
                                          color: Colors.white,
                                        ),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: true,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: const Color(0xff37434d),
                                    strokeWidth: 1,
                                  );
                                },
                                getDrawingVerticalLine: (value) {
                                  return FlLine(
                                    color: const Color(0xff37434d),
                                    strokeWidth: 1,
                                  );
                                },
                              ),
                              titlesData: FlTitlesData(
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: false,
                                  ),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: false,
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: bottomTitleWidgets,
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: leftTitleWidgets,
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: const Border(
                                  bottom: BorderSide(
                                      color: Color(0xff37434d), width: 1),
                                ),
                              ),
                              minX: dates[0].millisecondsSinceEpoch.toDouble(),
                              maxX: dates[dates.length - 1]
                                  .millisecondsSinceEpoch
                                  .toDouble(),
                              minY: weights.reduce(min) * 0.5,
                              maxY: weights.reduce(max) * 1.1,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: generateChartData(dates, weights),
                                  isCurved: true,
                                  color: lightblue,
                                  barWidth: 2,
                                  isStrokeCapRound: true,
                                  dotData: FlDotData(
                                    show: true,
                                    getDotPainter:
                                        (spot, percent, barData, index) =>
                                            FlDotCirclePainter(
                                      radius: 3,
                                      color: lightblue,
                                    ),
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: lightblue.withOpacity(0.3),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ),
            Text(
              'Die X-Achse repräsentiert das Datum und die Y-Achse das Gewicht an dem jeweiligen Datum.',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
