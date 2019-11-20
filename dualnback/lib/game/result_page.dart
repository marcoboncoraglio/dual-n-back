import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tuple/tuple.dart';

import 'game_state_provider.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key key}) : super(key: key);

  String _getLabel(int i) {
    String label;
    switch (i) {
      case 0:
        label = "Possible";
        break;
      case 1:
        label = "Correct"; // True Posivitve
        break;
      case 2:
        label = "Wrong"; // False Positive
        break;
    }
    return label;
  }

  List<_RoundResults> _makeResults(
      Map<MatchOption, Tuple3<int, int, int>> optionCounters, MatchOption opt) {
    List<_RoundResults> resultList = [];

    for (int i = 0; i < 3; i++) {
      switch (i) {
        case 0:
          resultList
              .add(new _RoundResults(_getLabel(i), optionCounters[opt].item1));
          break;
        case 1:
          resultList
              .add(new _RoundResults(_getLabel(i), optionCounters[opt].item2));
          break;
        case 2:
          resultList.add(new _RoundResults(
              _getLabel(i),
              optionCounters[opt].item3 +
                  optionCounters[opt].item1 -
                  optionCounters[opt].item2));
          break;
      }
    }

    return resultList;
  }

  Widget _makeRoundResultChart(context) {
    List<charts.Series<_RoundResults, String>> seriesList = [];

    GameStateProvider gameStateProvider =
        Provider.of<GameStateProvider>(context, listen: false);

    gameStateProvider.optionCounters.forEach((opt, tuple) => seriesList.add(
        new charts.Series<_RoundResults, String>(
            id: opt.toString().split('.')[1].toLowerCase(),
            seriesCategory: opt.toString().split('.')[1].toLowerCase(),
            data: _makeResults(gameStateProvider.optionCounters, opt),
            domainFn: (i, j) => i.label,
            measureFn: (i, j) => i.value)));

    return new SizedBox(
      height: 200,
      child: new charts.BarChart(
        seriesList,
        animate: true,
        barGroupingType: charts.BarGroupingType.grouped,
        behaviors: [new charts.SeriesLegend()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              "Round over!",
              style: new TextStyle(fontSize: 20),
            ),
          )),
          _makeRoundResultChart(context),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: RaisedButton(
                onPressed: () =>
                    null, // TODO: does not work, push this page to stack then pop here?
                child: Text("PLAY AGAIN!"),
              ),
            ),
          )
        ]);
  }
}

class _RoundResults {
  String label;
  int value;

  _RoundResults(this.label, this.value);
}
