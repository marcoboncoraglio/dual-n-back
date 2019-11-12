import 'package:dualnback/game_page.dart';
import 'package:dualnback/settings_page.dart';
import 'package:dualnback/statistics_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, @required this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyHomePageState(title);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.title);


  final String title;
  int _currentIndex = 0;
  final List<Widget> _children = [GamePage(), SettingsPage(), StatisticsPage()];


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        centerTitle: true,
      ),
      body: _children[_currentIndex],
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
