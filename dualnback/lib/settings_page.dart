import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game/game_state_provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    GameStateProvider gameStateProvider =
        Provider.of<GameStateProvider>(context, listen: false);
    int _level = gameStateProvider.level;
    int _speed = gameStateProvider.timerInterval;

    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: new Text(
                  "Level",
                  textScaleFactor: 1.3,
                  style: new TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          new Slider(
              min: 1,
              max: 10,
              divisions: 9,
              value: gameStateProvider.level.toDouble(),
              label: "$_level",
              onChanged: (val) =>
                  setState(() => gameStateProvider.level = val.toInt())),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: new Text(
                  "Time per round (ms)",
                  textScaleFactor: 1.3,
                  style: new TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          new Slider(
              min: 1000,
              max: 3000,
              divisions: 10,
              value: gameStateProvider.timerInterval.toDouble(),
              label: "$_speed",
              onChanged: (val) =>
                  setState(() => gameStateProvider.timerInterval = val.toInt())),
        ],
      ),
    );
  }
}
