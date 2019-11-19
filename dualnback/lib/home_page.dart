import 'dart:collection';

import 'package:dualnback/game_page.dart';
import 'package:dualnback/settings_page.dart';
import 'package:dualnback/statistics_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();

  int _currentIndex = 0;
  
  final LinkedHashMap<String, Widget> _children = new LinkedHashMap.from({
    "N-Back": GamePage(),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(_children.keys.toList()[_currentIndex]),
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
