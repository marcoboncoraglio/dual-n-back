import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: new Text(
        "Settings",
        style: new TextStyle(color: Colors.black, fontSize: 20.0),
      ),
    ));
  }
}
