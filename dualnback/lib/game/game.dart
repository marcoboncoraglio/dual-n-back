import 'dart:async';

import 'package:dualnback/game/game_buttons.dart';
import 'package:dualnback/game/game_round.dart';
import 'package:dualnback/game/grid.dart';
import 'package:dualnback/game/play_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_state_provider.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  Timer timer;

  void _generateNewRound() {
    Provider.of<GameStateProvider>(context).generateNewRound();
  }

  void _startGameTimer() {
    if (timer == null) {
      int timerInterval =
          Provider.of<GameStateProvider>(context, listen: false).timerInterval;
      timer = Timer.periodic(Duration(milliseconds: timerInterval),
          (Timer t) => _generateNewRound());
    }
  }

  void _reset() {
    //Provider.of<GameStateProvider>(context, listen: false).reset();
  }

  @override
  void dispose() {
    _reset();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GameStateProvider gameStateProvider =
        Provider.of<GameStateProvider>(context, listen: true);

    List<GameRound> gameRounds = gameStateProvider.gameRounds;

    int currentRound = gameStateProvider.currentRound;
    int level = gameStateProvider.level;

    // speak after build, make sure it only played when state is correct
    if (gameStateProvider.isPlaying) {
      gameRounds[currentRound].auditoryInput.speak();
      _startGameTimer();
    }

    return Column(children: <Widget>[
      new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(top: 15, left: 40, right: 130),
            child: Text("N=$level"),
          ),
          new Padding(
              padding: EdgeInsets.only(top: 15, right: 40, left: 130),
              child: new Center(child: Text("$currentRound/22"))),
        ],
      ),
      new Expanded(
          child: gameStateProvider.isPlaying
              ? new Grid(gameRounds[currentRound].index,
                  gameRounds[currentRound].visualInput)
              : new Grid.init()),
      new Padding(
          padding: EdgeInsets.only(right: 20, bottom: 50, left: 20),
          child: gameStateProvider.isPlaying
              ? new GameButtons()
              : new PlayButton())
    ]);
  }
}
