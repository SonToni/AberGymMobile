// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'AberGym',
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 42, 195, 255), // Farbe anpassen
        ),
      ),
      backgroundColor: const Color.fromRGBO(37, 37, 50, 1),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
