import 'package:car_notes/screens/setting_screen/settings_body.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  static const String id = "SettingScreen";
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Settings"),
      ),
      body: SettingsBody(),
    ));
  }
}
