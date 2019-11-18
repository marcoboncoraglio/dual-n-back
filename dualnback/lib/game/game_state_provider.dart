import 'package:flutter/widgets.dart';
import 'package:tuple/tuple.dart';

import 'game_round.dart';

enum MatchOption { POSITION, SOUND /* , SHAPE, COLOR */ }

class GameStateProvider with ChangeNotifier {
  List<GameRound> gameRounds = [new GameRound()];
  int currentRound = 0;

  int level = 1;
  int timerInterval = 2000;

  // option to correct, right, wrong
  Map<MatchOption, Tuple3<int, int, int>> optionCounters = {
    MatchOption.POSITION: new Tuple3(0, 0, 0),
    MatchOption.SOUND: new Tuple3(0, 0, 0),
    //MatchOption.SHAPE: new Tuple2(0, 0),
    //MatchOption.COLOR: new Tuple2(0, 0)
  };

  generateNewRound() {
    _checkOptions();
    gameRounds.add(new GameRound());
    currentRound++;
    notifyListeners();
  }

  bool _checkMatching(MatchOption option) {
    switch (option) {
      case MatchOption.POSITION:
        return gameRounds[gameRounds.length - level - 1].index ==
            gameRounds[gameRounds.length - 1].index;
      case MatchOption.SOUND:
        return gameRounds[gameRounds.length - level - 1].auditoryInput.letter ==
            gameRounds[gameRounds.length - 1].auditoryInput.letter;
      /* case MatchOption.SHAPE:
      case MatchOption.COLOR: */
    }
    return false;
  }

  void _checkOptions() {
    if (gameRounds.length - level > 0) {
      for (MatchOption opt in optionCounters.keys) {
        if (_checkMatching(opt)) {
          optionCounters[opt] = new Tuple3(optionCounters[opt].item1 + 1,
              optionCounters[opt].item2, optionCounters[opt].item3);
        }
      }
    }
  }

  pressedOption(MatchOption option) {
    if (gameRounds.length - level > 0) {
      if (!gameRounds[currentRound].pressed[option]) {
        gameRounds[currentRound].pressed[option] = true;
        if (_checkMatching(option)) {
          optionCounters[option] = new Tuple3(
              optionCounters[option].item1, optionCounters[option].item2 + 1, optionCounters[option].item3);
        }
        else optionCounters[option] = new Tuple3(
              optionCounters[option].item1, optionCounters[option].item2, optionCounters[option].item3 + 1);
      }
    }
  }
}
