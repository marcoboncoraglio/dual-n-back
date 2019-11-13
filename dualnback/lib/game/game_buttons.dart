import 'package:flutter/material.dart';

class GameButtons extends StatefulWidget {
  @override
  _GameButtonsState createState() => _GameButtonsState();
}

class _GameButtonsState extends State<GameButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        new Column(children: <Widget>[
          new SizedBox(
            height: 50,
            width: 160,
            child: new RaisedButton(
                onPressed: null,
                child: Text("POSITION",
                    style: TextStyle(fontSize: 20, color: Colors.black))),
          ),
          new Text("Correct")
        ]),
        new Padding(padding: EdgeInsets.only(right: 15)),
        new Column(
          children: <Widget>[
            new SizedBox(
              height: 50,
              width: 160,
              child: new RaisedButton(
                  onPressed: null,
                  child: Text("SOUND",
                      style: TextStyle(fontSize: 20, color: Colors.black))),
            ),
            new Text("Wrong")
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
