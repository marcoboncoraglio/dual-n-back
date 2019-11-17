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

    int correct = gameStateProvider.optionCounters.values
        .map((tuple) => tuple.item2)
        .reduce((curr, next) => curr + next);

    // possible - correct + pressed wrong
    int wrong = gameStateProvider.optionCounters.values
            .map((tuple) => tuple.item1)
            .reduce((curr, next) => curr + next) +
        gameStateProvider.optionCounters.values
            .map((tuple) => tuple.item3)
            .reduce((curr, next) => curr + next) -
        correct;

    // TODO: refactor to custom button, pass in matchoption
    return Row(
      children: <Widget>[
        new Column(children: <Widget>[
          new SizedBox(
            height: 50,
            width: 160,
            child: new RaisedButton(
                onPressed: () =>
                    gameStateProvider.pressedOption(MatchOption.POSITION),
                child: Text("POSITION",
                    style: TextStyle(fontSize: 20, color: Colors.black))),
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
              width: 160,
              child: new RaisedButton(
                  onPressed: () =>
                      gameStateProvider.pressedOption(MatchOption.SOUND),
                  child: Text("SOUND",
                      style: TextStyle(fontSize: 20, color: Colors.black))),
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
