import 'package:dualnback/game/statistics_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './game_state_provider.dart';

class GameButtons extends StatefulWidget {
  @override
  _GameButtonsState createState() => _GameButtonsState();
}

class _GameButtonsState extends State<GameButtons> {
  @override
  Widget build(BuildContext context) {
    final gameStateProvider =
        Provider.of<GameStateProvider>(context, listen: true);

    int correct = StatisticsUtil.getTotalPlayerCorrect(gameStateProvider.optionCounters);

    int wrong = StatisticsUtil.getTotalPlayerWrong(gameStateProvider.optionCounters);

    // TODO: refactor to custom button, pass in matchoption?
    return Row(
      children: <Widget>[
        new Column(children: <Widget>[
          new SizedBox(
            height: 50,
            width: 120,
            child: new RaisedButton(
                onPressed: () =>
                    gameStateProvider.pressedOption(MatchOption.POSITION),
                child: Text("POSITION",
                    style: TextStyle(fontSize: 15, color: Colors.black))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: new Text("Correct: $correct"),
          )
        ]),
        new Padding(padding: EdgeInsets.only(right: 15)),
        new Column(
          children: <Widget>[
            new SizedBox(
              height: 50,
              width: 120,
              child: new RaisedButton(
                  onPressed: () =>
                      gameStateProvider.pressedOption(MatchOption.SOUND),
                  child: Text("SOUND",
                      style: TextStyle(fontSize: 15, color: Colors.black))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: new Text("Wrong: $wrong"),
            )
          ],
        ),
        /*
        new Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Row(
              children: <Widget>[
                new SizedBox(
                  height: 50,
                  width: 160,
                  child:
                      new RaisedButton(onPressed: null, child: Text("COLOR")),
                ),
                new Padding(padding: EdgeInsets.only(right: 15)),
                new SizedBox(
                  height: 50,
                  width: 160,
                  child:
                      new RaisedButton(onPressed: null, child: Text("SHAPE")),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ))
        */
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
