import 'package:flutter/material.dart';

class DataTableExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: ListView(children: <Widget>[
        // ignore: prefer_const_constructors
        Center(
            child: const Text(
          'Gesamtkörper Workout',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        DataTable(
          // ignore: prefer_const_literals_to_create_immutables
          columns: [
            const DataColumn(
                label: Text('ID',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            const DataColumn(
                label: Text('Name',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            const DataColumn(
                label: Text('Profession',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ],
          // ignore: prefer_const_literals_to_create_immutables
          rows: [
            const DataRow(cells: [
              DataCell(Text('1')),
              DataCell(Text('Antonio')),
              DataCell(Text('Actor')),
            ]),
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
      ])),
    );
  }
}
