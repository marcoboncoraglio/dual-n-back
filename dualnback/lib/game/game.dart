import 'dart:async';

import 'package:dualnback/game/game_buttons.dart';
import 'package:dualnback/game/game_round.dart';
import 'package:dualnback/game/grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_state_provider.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  Timer timer;

  void generateNewRound() {
    Provider.of<GameStateProvider>(context).generateNewRound();
  }

  @override
  void initState() {
    int timerInterval = Provider.of<GameStateProvider>(context, listen: false).timerInterval;
    super.initState();
    timer = Timer.periodic(
        Duration(milliseconds: timerInterval), (Timer t) => generateNewRound());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<GameRound> gameRounds =
        Provider.of<GameStateProvider>(context, listen: false).gameRounds;

    int currentRound =
        Provider.of<GameStateProvider>(context, listen: false).currentRound;

    int level = Provider.of<GameStateProvider>(context, listen: false).level;

    return Column(children: <Widget>[
      new Padding(
          padding: EdgeInsets.only(top: 15),
          child: new Center(child: Text("N = $level"))),
      new Expanded(
          child: new Grid(gameRounds[currentRound].index,
              gameRounds[currentRound].visualInput)),
      new Padding(
          padding: EdgeInsets.only(right: 20, bottom: 30, left: 20),
          child: new GameButtons()),
    ]);
  }
}
