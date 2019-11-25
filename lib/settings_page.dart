import 'package:dualnback/game/auditory_input.dart';
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

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Game",
            style: TextStyle(fontSize: 26),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                "Level",
                style: new TextStyle(color: Colors.black),
              ),
              new Slider(
                  min: 1,
                  max: 10,
                  divisions: 9,
                  value: gameStateProvider.level.toDouble(),
                  label: "${gameStateProvider.level}",
                  onChanged: (val) =>
                      setState(() => gameStateProvider.level = val.toInt())),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                "Time per round",
                style: new TextStyle(color: Colors.black),
              ),
              new Slider(
                  min: 1000,
                  max: 3000,
                  divisions: 10,
                  value: gameStateProvider.timerInterval.toDouble(),
                  label: "${gameStateProvider.timerInterval}",
                  onChanged: (val) => setState(
                      () => gameStateProvider.timerInterval = val.toInt())),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                "Total rounds",
                style: new TextStyle(color: Colors.black),
              ),
              new Slider(
                  min: 15,
                  max: 40,
                  divisions: 34,
                  value: gameStateProvider.totalRounds.toDouble(),
                  label: "${gameStateProvider.totalRounds}",
                  onChanged: (val) => setState(
                      () => gameStateProvider.totalRounds = val.toInt())),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "UI",
            style: TextStyle(fontSize: 26),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                "Sound",
                style: new TextStyle(color: Colors.black),
              ),
              new Slider(
                  min: 0,
                  max: 100,
                  divisions: 99,
                  value: AuditoryInput.speechVolume,
                  label: "${AuditoryInput.speechVolume.toInt()}",
                  onChanged: (val) => setState(
                      () => AuditoryInput.speechVolume = val)),
            ],
          ),
        ],
      ),
    );
  }
}
