import 'package:flutter/widgets.dart';

import 'game_round.dart';

class GameRoundsProvider with ChangeNotifier {
  List<GameRound> gameRounds = [];
  int currentRound = -1;

  void generateNewRound() {
    gameRounds.add(new GameRound());
    currentRound++;
    notifyListeners();
  }
}
