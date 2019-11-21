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
    int _interval = gameStateProvider.timerInterval;
    int _totalRounds = gameStateProvider.totalRounds;

    return Padding(
      padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                "Level",
                textScaleFactor: 1.2,
                style: new TextStyle(color: Colors.black),
              ),
              new Slider(
                  min: 1,
                  max: 10,
                  divisions: 9,
                  value: gameStateProvider.level.toDouble(),
                  label: "$_level",
                  onChanged: (val) =>
                      setState(() => gameStateProvider.level = val.toInt())),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                "Time per round (ms)",
                textScaleFactor: 1.2,
                style: new TextStyle(color: Colors.black),
              ),
              new Slider(
                  min: 1000,
                  max: 3000,
                  divisions: 10,
                  value: gameStateProvider.timerInterval.toDouble(),
                  label: "$_interval",
                  onChanged: (val) => setState(
                      () => gameStateProvider.timerInterval = val.toInt())),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                "Rounds per game",
                textScaleFactor: 1.2,
                style: new TextStyle(color: Colors.black),
              ),
              new Slider(
                  min: 15,
                  max: 40,
                  divisions: 34,
                  value: gameStateProvider.totalRounds.toDouble(),
                  label: "$_totalRounds",
                  onChanged: (val) => setState(
                      () => gameStateProvider.totalRounds = val.toInt())),
            ],
          ),
        ],
      ),
    );
  }
}
