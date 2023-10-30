import 'package:car_notes/screens/add_papers/add_papers_screen.dart';
import 'package:car_notes/screens/add_refueling/add_refueling_screen.dart';
import 'package:car_notes/screens/add_reminders/add_reminders_screen.dart';
import 'package:car_notes/screens/add_services/add_services_screen.dart';
import 'package:car_notes/screens/repair_screens/repair_screen.dart';
import 'package:car_notes/screens/setting_screen/setting_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CarNote());
}

class CarNote extends StatefulWidget {
  const CarNote({super.key});

  @override
  State<CarNote> createState() => _CarNoteState();
}

class _CarNoteState extends State<CarNote> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SafeArea(
        child: Repair(),
      ),
      routes: {
        SettingScreen.id: (context) => SettingScreen(),
        AddRefueling.id: (context) => AddRefueling(),
        AddServiceScreen.id: (context) => AddServiceScreen(),
        AddPapersScreen.id: (context) => AddPapersScreen(),
        AddRemindersScreen.id: (context) => AddRemindersScreen(),
      },
    );
  }
}
