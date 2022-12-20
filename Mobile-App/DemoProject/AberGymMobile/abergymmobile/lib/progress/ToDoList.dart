import 'package:abergymmobile/home/Home.dart';
import 'package:abergymmobile/progress/SetCounter.dart';
import 'package:abergymmobile/update/UpdateBody.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  late String wname = "";
  late List<String> wereps = [];
  late List<String> wesets = [];
  late List<String> weweight = [];
  late List<String> ename = [];
  late int amountrows = 0;
  Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);
  List<bool> finishedExcersiceList = [];
  int counter = 0;
  bool finished = false;

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    wname = await prefs.getString('wname')!;
    wereps = await prefs.getStringList('wereps')!;
    wesets = await prefs.getStringList('wesets')!;
    weweight = await prefs.getStringList('weweight')!;
    ename = await prefs.getStringList('ename')!;
    amountrows = await prefs.getInt('amountrows')!;

    for (int i = 0; i < amountrows; i++) {
      if (prefs.get('finishedExcersice_$i') == true) {
        finishedExcersiceList.add(true);
        setState(() {
          counter++;
        });
      } else {
        finishedExcersiceList.add(false);
      }
    }
    if (counter == amountrows) {
      setState(() {
        finished = true;
      });
    }
    setState(() {
      wname = wname;
      wereps = wereps;
      wesets = wesets;
      wesets = wesets;
      weweight = weweight;
      ename = ename;
      amountrows = amountrows;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkgrey,
      body: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              height: 70,
              child: Text(
                wname,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: lightblue,
                ),
                textAlign: TextAlign.center,
              ),
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
                  color: lightblue,
                  width: 5.0,
                ),
              ),
              child: Column(
                children: <Widget>[
                  if (finished == false) ...[
                    for (int i = 0; i < amountrows; i++) ...[
                      if (finishedExcersiceList[i] == false ||
                          finishedExcersiceList[i] == null) ...[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SetCounter(
                                  index: i,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 78,
                            margin: const EdgeInsets.only(
                              top: 3.8,
                              right: 12,
                              left: 12,
                              bottom: 3.8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color.fromARGB(255, 42, 195, 255),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    (ename.isNotEmpty
                                        ? ename[i].toString()
                                        : ""),
                                    textScaleFactor: 2,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: darkgrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Table(
                                  children: [
                                    TableRow(
                                      children: [
                                        Center(
                                          child: Text(
                                            (wesets.isNotEmpty
                                                ? 'Sätze: ${wesets[i].toString()}'
                                                : ""),
                                            textScaleFactor: 1.5,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: darkgrey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            (wereps.isNotEmpty
                                                ? 'Wdh: ${wereps[i].toString()}'
                                                : ""),
                                            textScaleFactor: 1.5,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: darkgrey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            (weweight.isNotEmpty
                                                ? 'Kg: ${weweight[i].toString()}'
                                                : ""),
                                            textScaleFactor: 1.5,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: darkgrey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                    ],
                    for (int i = 0; i < amountrows; i++) ...[
                      if (finishedExcersiceList[i] == true) ...[
                        Container(
                          height: 78,
                          margin: const EdgeInsets.only(
                            top: 3.8,
                            right: 12,
                            left: 12,
                            bottom: 3.8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color.fromARGB(255, 25, 68, 85),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  (ename.isNotEmpty ? ename[i].toString() : ""),
                                  textScaleFactor: 2,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: darkgrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Table(
                                children: [
                                  TableRow(
                                    children: [
                                      Center(
                                        child: Text(
                                          (wesets.isNotEmpty
                                              ? 'Sätze: ${wesets[i].toString()}'
                                              : ""),
                                          textScaleFactor: 1.5,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: darkgrey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          (wereps.isNotEmpty
                                              ? 'Wdh: ${wereps[i].toString()}'
                                              : ""),
                                          textScaleFactor: 1.5,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: darkgrey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          (weweight.isNotEmpty
                                              ? 'Kg: ${weweight[i].toString()}'
                                              : ""),
                                          textScaleFactor: 1.5,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: darkgrey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ] else ...[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 250, bottom: 10),
                          child: Text(
                            "Wollen Sie an diesen Workoutplan Änderungen vornehmen?",
                            style: TextStyle(color: lightblue, fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  Center(
                                    child: GestureDetector(
                                      onTap: () async {
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        for (int i = 0; i < amountrows; i++) {
                                          prefs.remove('finishedExcersice_$i');
                                        }
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            duration:
                                                Duration(milliseconds: 500),
                                            child: const Home(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 42, 195, 255),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              'Nein',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type:
                                                PageTransitionType.bottomToTop,
                                            duration:
                                                Duration(milliseconds: 350),
                                            child: UpdateBody(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 42, 195, 255),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              'Ja',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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
}
