import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: new Text(
        "Statistics",
        style: new TextStyle(color: Colors.black, fontSize: 20.0),
      ),
    ));
  }
}
