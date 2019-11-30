import 'dart:async';

import 'package:dualnback/game/game_buttons.dart';
import 'package:dualnback/game/game_round.dart';
import 'package:dualnback/game/grid.dart';
import 'package:dualnback/game/play_button.dart';
import 'package:dualnback/game/result_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../statistics_db.dart';
import 'game_settings.dart';
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
      timer = Timer.periodic(Duration(milliseconds: GameSettings.timerInterval),
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

    // speak after build, make sure it only played when state is correct
    if (gameStateProvider.isPlaying) {
      _startGameTimer();
      gameRounds[currentRound].auditoryInput.speak();
    }

    if (currentRound >= GameSettings.totalRounds) {
      timer?.cancel();

      StatisticsDB.dbProvider
          .insertRecord(gameStateProvider.optionCounters, GameSettings.level);

      Future.delayed(
          new Duration(milliseconds: GameSettings.timerInterval),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => ResultPage())));
    }

    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("N=${GameSettings.level}"),
            Text("$currentRound/${GameSettings.totalRounds}"),
          ],
        ),
      ),
      new Expanded(
          child: gameStateProvider.isPlaying
              ? new Grid(gameRounds[currentRound].index,
                  gameRounds[currentRound].visualInput)
              : new Grid.init()),
      new Padding(
          padding: EdgeInsets.only(right: 20, bottom: 10, left: 20),
          child: gameStateProvider.isPlaying
              ? new GameButtons()
              : new PlayButton()),
    ]);
  }
}
