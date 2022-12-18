// ignore_for_file: file_names

import 'package:abergymmobile/common/SqlTable.dart';
import 'package:flutter/material.dart';

class SecondBody extends StatelessWidget {
  const SecondBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SqlTable(version: 2);
  }
}
