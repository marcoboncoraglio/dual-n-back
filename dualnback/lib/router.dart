import 'dart:collection';

import 'package:dualnback/game_page.dart';
import 'package:dualnback/settings_page.dart';
import 'package:dualnback/statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game/game_state_provider.dart';

class Router extends StatefulWidget {
  Router({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _RouterState();
}

class _RouterState extends State<Router> {
  _RouterState();

  int _currentIndex = 0;

  final LinkedHashMap<String, Widget> _children = new LinkedHashMap.from({
    "-Back": GamePage(),
    "Settings": SettingsPage(),
    "Statistics": StatisticsPage()
  });

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    GameStateProvider gameStateProvider =
        Provider.of<GameStateProvider>(context, listen: false);

    String _title = gameStateProvider.level.toString() + _children.keys.toList()[_currentIndex];
        
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
      ),
      body: _children.values.toList()[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            title: Text('Play'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            title: Text('Statistics'),
          ),
        ],
      ),
    );
  }
}
