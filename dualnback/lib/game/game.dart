import 'dart:math';

import 'package:dualnback/game/game_round.dart';
import 'package:dualnback/game/grid.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  // timer
  // function to create new rounds
  List<GameRound> gameRounds = [new GameRound()];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Expanded(
            child:
                new Grid(new Random().nextInt(9), gameRounds[0].visualInput)),
        new Padding(
            padding: EdgeInsets.only(right: 20, bottom: 60, left: 20),
            child: Row(
              children: <Widget>[
                new SizedBox(
                  height: 50,
                  width: 160,
                  child: new RaisedButton(
                      onPressed: null,
                      child: Text("POSITION",
                          style: TextStyle(fontSize: 20, color: Colors.black))),
                ),
                new Padding(padding: EdgeInsets.only(right: 15)),
                new SizedBox(
                  height: 50,
                  width: 160,
                  child: new RaisedButton(
                      onPressed: null,
                      child: Text("SOUND",
                          style: TextStyle(fontSize: 20, color: Colors.black))),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )),
        /*
        new Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Row(
              children: <Widget>[
                new SizedBox(
                  height: 50,
                  width: 160,
                  child: new RaisedButton(
                      onPressed: null, child: Text("COLOR")),
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
            )),
            */
      ],
    );
  }
}
