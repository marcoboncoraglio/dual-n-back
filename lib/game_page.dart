import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'game/game.dart';

class GamePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Game());
  }
}
