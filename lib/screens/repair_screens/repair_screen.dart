import 'package:car_notes/screens/papers_screen/papers_screen.dart';
import 'package:car_notes/screens/refueling_screen/refueling_screen.dart';
import 'package:car_notes/screens/repair_screens/repair_body.dart';
import 'package:car_notes/screens/reports_screen/reports_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../reminders_screen/reminders_screen.dart';

class Repair extends StatefulWidget {
  static const String id = "Repair";

  const Repair({super.key});

  @override
  State<Repair> createState() => _RepairState();
}

class _RepairState extends State<Repair> {
  int _index = 0;
  final screens = [
    RefuelingScreen(),
    RepairBody(),
    Papers(),
    Reminders(),
    Reports()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimaryColor,
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        selectedItemColor: Colors.deepPurpleAccent,
        elevation: 0,
        unselectedItemColor: Colors.white,
        items: [
          CarNoteBottomNavigationBar(
              iconData: Icons.oil_barrel, label: "Refuel"),
          CarNoteBottomNavigationBar(
              iconData: Icons.car_repair, label: "Repairs"),
          CarNoteBottomNavigationBar(iconData: Icons.note_alt, label: "Papers"),
          CarNoteBottomNavigationBar(
              iconData: Icons.notifications, label: "Reminders"),
          CarNoteBottomNavigationBar(
              iconData: Icons.auto_graph_sharp, label: "Reports"),
        ],
      ),
    );
  }
}

BottomNavigationBarItem CarNoteBottomNavigationBar(
    {required IconData iconData, required String label}) {
  return BottomNavigationBarItem(
      icon: Icon(iconData), label: label, backgroundColor: Colors.black26);
}
