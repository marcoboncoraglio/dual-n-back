import 'package:dualnback/game/game_state_provider.dart';
import 'package:dualnback/game_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'game/game.dart';

class GamePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(builder: (context) => GameStateProvider()),
      ChangeNotifierProvider(builder: (context) => GameSettingsProvider(),)
    ], child: Container(child: Game()));
  }
}
