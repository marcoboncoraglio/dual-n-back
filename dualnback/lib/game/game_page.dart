import 'package:dualnback/game/game_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GamePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<GameButton> gameButtons;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: new Text(
        "Game",
        style: new TextStyle(color: Colors.black, fontSize: 20.0),
      ),
    ));
  }
}
