import 'package:abergymmobile/common/SqlTable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _blackMode = false;
  Color? _color = null;
  Color? _backgroundColor = null;
  Color? _fontColor = null;

  void saveColors() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('backgroundColor', _backgroundColor.toString());
    prefs.setString('fontColor', _fontColor.toString());
    prefs.setString('color', _color.toString());
    prefs.setBool('blackMode', _blackMode);
  }

  void getColors() async {
    final prefs = await SharedPreferences.getInstance();

    String backgroundColor = await prefs.getString('backgroundColor')!;
    String fontColor = await prefs.getString('fontColor')!;
    String color = await prefs.getString('color')!;
    bool blackMode = await prefs.getBool('blackMode')!;

    setState(() {
      _backgroundColor = Color(int.parse(backgroundColor.substring(6, 16)));
      _fontColor = Color(int.parse(fontColor.substring(6, 16)));
      _color = Color(int.parse(color.substring(6, 16)));
      _blackMode = blackMode;
    });
  }

  @override
  void initState() {
    super.initState();
    getColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      bottomSheet: Container(
        color: _backgroundColor,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              backgroundColor: _backgroundColor,
              leading: IconButton(
                icon: Icon(
                  Icons.close,
                  color: _fontColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                'Einstellungen',
                style: TextStyle(color: _fontColor),
              ),
            ),
            SwitchListTile(
              activeColor: _color,
              title: Text(
                'Dark Mode',
                style: TextStyle(color: _fontColor),
              ),
              value: _blackMode,
              onChanged: (value) {
                setState(() {
                  _blackMode = value;
                  if (_blackMode == true) {
                    _backgroundColor = Color.fromRGBO(37, 37, 50, 1);
                    _fontColor = Color.fromARGB(255, 255, 255, 255);
                    saveColors();
                  } else {
                    _backgroundColor = Color.fromRGBO(228, 229, 241, 1);
                    _fontColor = Color.fromRGBO(37, 37, 50, 1);
                    saveColors();
                  }
                });
              },
            ),
            ListTile(
              title: Text(
                'Farbauswahl',
                style: TextStyle(color: _fontColor),
              ),
              trailing: DropdownButton(
                dropdownColor: _backgroundColor,
                value: _color,
                underline: Container(
                  height: 0.5,
                  color: _fontColor,
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: _fontColor,
                ),
                items: [
                  DropdownMenuItem(
                    child: Text(
                      'Hellblau',
                      style: TextStyle(
                        color: Color.fromARGB(255, 42, 195, 255),
                      ),
                    ),
                    value: Color.fromARGB(255, 42, 195, 255),
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Gold',
                      style: TextStyle(
                        color: Color.fromRGBO(212, 175, 55, 1.000),
                      ),
                    ),
                    value: Color.fromRGBO(212, 175, 55, 1.000),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _color = value!;
                    saveColors();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
