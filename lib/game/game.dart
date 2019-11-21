import 'dart:async';

import 'package:dualnback/game/game_buttons.dart';
import 'package:dualnback/game/game_round.dart';
import 'package:dualnback/game/grid.dart';
import 'package:dualnback/game/play_button.dart';
import 'package:dualnback/game/result_page.dart';
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
    if (timer == null || !timer.isActive) {
      int timerInterval =
          Provider.of<GameStateProvider>(context, listen: false).timerInterval;
      timer = Timer.periodic(Duration(milliseconds: timerInterval),
          (Timer t) => _generateNewRound());
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    Provider.of<GameStateProvider>(context, listen: false).reset();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GameStateProvider gameStateProvider =
        Provider.of<GameStateProvider>(context, listen: true);

    List<GameRound> gameRounds = gameStateProvider.gameRounds;

    int currentRound = gameStateProvider.currentRound;
    int totalRounds = gameStateProvider.totalRounds;
    int level = gameStateProvider.level;

    // speak after build, make sure it only played when state is correct
    if (gameStateProvider.isPlaying) {
      _startGameTimer();
      gameRounds[currentRound].auditoryInput.speak();
    }

    if (currentRound >= totalRounds) {
      timer?.cancel();

      //return ResultPage();

      Future.delayed(
          new Duration(milliseconds: gameStateProvider.timerInterval),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => ResultPage())));
    }

    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("N=$level"),
            Text("$currentRound/$totalRounds"),
          ],
        ),
      ),
      new Expanded(
          child: gameStateProvider.isPlaying
              ? new Grid(gameRounds[currentRound].index,
                  gameRounds[currentRound].visualInput)
              : new Grid.init()),
      new Padding(
          padding: EdgeInsets.only(right: 20, bottom: 15, left: 20),
          child: gameStateProvider.isPlaying
              ? new GameButtons()
              : new PlayButton()),
    ]);
  }
}
