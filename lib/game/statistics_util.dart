import 'package:tuple/tuple.dart';

import 'game_state_provider.dart';

class StatisticsUtil {
  static int getTotalPossibleCorrect(
      Map<MatchOption, Tuple3<int, int, int>> optionCounters) {
    return optionCounters.values
        .map((tuple) => tuple.item1)
        .reduce((curr, next) => curr + next);
  }

  static int getTotalPlayerCorrect(
      Map<MatchOption, Tuple3<int, int, int>> optionCounters) {
    return optionCounters.values
        .map((tuple) => tuple.item2)
        .reduce((curr, next) => curr + next);
  }

  static int getTotalPlayerWrong(
      Map<MatchOption, Tuple3<int, int, int>> optionCounters) {
    return getTotalPossibleCorrect(optionCounters) -
        getTotalPlayerCorrect(optionCounters) +
        optionCounters.values
            .map((tuple) => tuple.item3)
            .reduce((curr, next) => curr + next);
  }

  static double getCorrectPercentage(
      MatchOption opt, Map<MatchOption, Tuple3<int, int, int>> optionCounters) {
    int possible = optionCounters[opt].item1;
    int correct = optionCounters[opt].item2;
    int wrong = optionCounters[opt].item3;

    if (correct - wrong >= 0 && possible > 0) {
      return ((correct - wrong) / possible) * 100;
    } else
      return 0;
  }
}
