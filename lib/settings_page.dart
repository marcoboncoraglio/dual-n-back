import 'package:dualnback/game/auditory_input.dart';
import 'package:dualnback/game/game_settings.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void dispose() {
    GameSettings.save();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  value: GameSettings.level.toDouble(),
                  label: "${GameSettings.level}",
                  onChanged: (val) =>
                      setState(() => GameSettings.level = val.toInt())),
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
                  value: GameSettings.timerInterval.toDouble(),
                  label: "${GameSettings.timerInterval}",
                  onChanged: (val) =>
                      setState(() => GameSettings.timerInterval = val.toInt())),
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
                  value: GameSettings.totalRounds.toDouble(),
                  label: "${GameSettings.totalRounds}",
                  onChanged: (val) =>
                      setState(() => GameSettings.totalRounds = val.toInt())),
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
                  value: GameSettings.speechVolume,
                  label: "${GameSettings.speechVolume.toInt()}",
                  onChanged: (val) => {
                        setState(() => GameSettings.speechVolume = val),
                        AuditoryInput.setSpeechVolume()
                      }),
            ],
          ),
        ],
      ),
    );
  }
}
