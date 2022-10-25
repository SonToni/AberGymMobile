import 'package:flutter/material.dart';

class DataTableExample extends StatelessWidget {
  const DataTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(37, 37, 50, 1),
        body: ListView(children: <Widget>[
          // ignore: prefer_const_constructors
          Center(
              child: const Text(
            'Gesamtkörper Workout',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 42, 195, 255)),
          )),
          DataTable(
            // ignore: prefer_const_literals_to_create_immutables
            columns: [
              const DataColumn(
                  label: Text('ID',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 42, 195, 255)))),
              const DataColumn(
                  label: Text('Name',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 42, 195, 255)))),
              const DataColumn(
                  label: Text('Profession',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 42, 195, 255)))),
            ],
            // ignore: prefer_const_literals_to_create_immutables
            rows: [
              const DataRow(cells: [
                DataCell(Text('5')),
                DataCell(Text('John')),
                DataCell(Text('Student')),
              ]),
              const DataRow(cells: [
                DataCell(Text('10')),
                DataCell(Text('Harry')),
                DataCell(Text('Leader')),
              ]),
              const DataRow(cells: [
                DataCell(Text('15')),
                DataCell(Text('Peter')),
                DataCell(Text('Scientist')),
              ]),
              const DataRow(cells: [
                DataCell(Text('15')),
                DataCell(Text('Peter')),
                DataCell(Text('Scientist')),
              ]),
              const DataRow(cells: [
                DataCell(Text('15')),
                DataCell(Text('Peter')),
                DataCell(Text('Scientist')),
              ]),
              const DataRow(cells: [
                DataCell(Text('15')),
                DataCell(Text('Peter')),
                DataCell(Text('Scientist')),
              ]),
              const DataRow(cells: [
                DataCell(Text('15')),
                DataCell(Text('Peter')),
                DataCell(Text('Scientist')),
              ]),
              const DataRow(cells: [
                DataCell(Text('15')),
                DataCell(Text('Peter')),
                DataCell(Text('Scientist')),
              ]),
              const DataRow(cells: [
                DataCell(Text('15')),
                DataCell(Text('Peter')),
                DataCell(Text('Scientist')),
              ]),
              const DataRow(cells: [
                DataCell(Text('15')),
                DataCell(Text('Peter')),
                DataCell(Text('Scientist')),
              ]),
              const DataRow(cells: [
                DataCell(Text('15')),
                DataCell(Text('Peter')),
                DataCell(Text('Scientist')),
              ]),
              const DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Antonio')),
                DataCell(Text('Actor')),
              ]),
              const DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Antonio')),
                DataCell(Text('Actor')),
              ]),
              const DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Antonio')),
                DataCell(Text('Actor')),
              ]),
              const DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Antonio')),
                DataCell(Text('Actor')),
              ]),
              const DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Antonio')),
                DataCell(Text('Actor')),
              ]),
            ],
          ),
        ]));
  }
}
