import 'package:dualnback/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game/game_state_provider.dart';

void main() => runApp(ChangeNotifierProvider(
    builder: (context) => GameStateProvider(),
    child: Container(child: MyApp())));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'N-Back',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Router());
  }
}
