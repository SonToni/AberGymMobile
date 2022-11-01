import 'package:abergymmobile/progressSystem/psBody.dart';
import 'package:flutter/material.dart';

class PSMain extends StatelessWidget {
  const PSMain({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 60, 60, 75),
              title: const Text('Sind Sie sich sicher?',
                  style: TextStyle(color: Colors.white)),
              content: const Text('Wollen Sie das Workout beenden',
                  style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(false), //<-- SEE HERE
                  child: const Text('Nein'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(true), // <-- SEE HERE
                  child: const Text('Ja'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: const Scaffold(
        backgroundColor: Color.fromRGBO(37, 37, 50, 1),
        body: PSBody(),
      ),
    );
  }
}
