import 'package:abergymmobile/update/UpdateExcersice.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateList extends StatefulWidget {
  const UpdateList({super.key});

  @override
  State<UpdateList> createState() => _UpdateListState();
}

class _UpdateListState extends State<UpdateList> {
  late String wname = "";
  late List<String> wereps = [];
  late List<String> wesets = [];
  late List<String> weweight = [];
  late List<String> ename = [];
  late int amountrows = 0;
  Color lightblue = const Color.fromARGB(255, 42, 195, 255);
  Color darkgrey = const Color.fromRGBO(37, 37, 50, 1);

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    wname = await prefs.getString('wname')!;
    wereps = await prefs.getStringList('wereps')!;
    wesets = await prefs.getStringList('wesets')!;
    weweight = await prefs.getStringList('weweight')!;
    ename = await prefs.getStringList('ename')!;
    amountrows = await prefs.getInt('amountrows')!;

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
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    for (int i = 0; i < amountrows; i++) ...[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateExcersice(
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
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
