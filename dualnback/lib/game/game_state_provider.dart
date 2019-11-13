import 'package:flutter/widgets.dart';

import 'game_round.dart';

class GameStateProvider with ChangeNotifier {
  List<GameRound> gameRounds = [new GameRound()];
  int currentRound = 0;

  void generateNewRound() {
    gameRounds.add(new GameRound());
    currentRound++;
    notifyListeners();
  }
}