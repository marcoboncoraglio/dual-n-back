import 'dart:async';

import 'package:dualnback/game/game_buttons.dart';
import 'package:dualnback/game/game_round.dart';
import 'package:dualnback/game/game_rounds_provider.dart';
import 'package:dualnback/game/grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  Timer timer;
  int level = 1;

  void generateNewRound() {
    setState(() {
      Provider.of<GameRoundsProvider>(context, listen: false).generateNewRound();
    });
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => generateNewRound());
    generateNewRound();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<GameRound> gameRounds = Provider.of<GameRoundsProvider>(context, listen: false).gameRounds;
    int currentRound = Provider.of<GameRoundsProvider>(context, listen: false).currentRound;

    return Column(children: <Widget>[
      new Padding(
          padding: EdgeInsets.only(top: 15),
          child: new Center(child: Text("N = $level"))),
      new Expanded(
          child: new Grid(gameRounds[currentRound].randomIndex,
              gameRounds[currentRound].visualInput)),
      new Padding(
          padding: EdgeInsets.only(right: 20, bottom: 30, left: 20),
          child: new GameButtons()),
    ]);
  }
}
