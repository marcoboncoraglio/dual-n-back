import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'game_state_provider.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key key}) : super(key: key);

  Widget _makeRoundResultChart(GameStateProvider gameStateProvider) {
    List<charts.Series<_RoundResults, String>> seriesList = [];

    gameStateProvider.optionCounters.forEach(
        (opt, tuple) => seriesList.add(new charts.Series<_RoundResults, String>(
            id: opt.toString().split('.')[1].toLowerCase(),
            seriesCategory: opt.toString().split('.')[1].toLowerCase(),
            data: List<_RoundResults>.from([
              _RoundResults(opt.toString().split('.')[1].toLowerCase(),
                  gameStateProvider.getCorrectPercentage(opt))
            ]),
            domainFn: (i, j) => i.option,
            measureFn: (i, j) => i.percent)));

    return new SizedBox(
      height: 150,
      child: new charts.BarChart(
        seriesList,
        primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec: new charts.StaticNumericTickProviderSpec(
            <charts.TickSpec<num>>[
              charts.TickSpec<num>(0),
              charts.TickSpec<num>(25),
              charts.TickSpec<num>(50),
              charts.TickSpec<num>(75),
              charts.TickSpec<num>(100),
            ],
          ),
        ),
        animate: true,
        barGroupingType: charts.BarGroupingType.grouped,
        behaviors: [new charts.SeriesLegend()],
      ),
    );
  }

  void _reset(context) {
    final GameStateProvider provider =
        Provider.of<GameStateProvider>(context, listen: false);
    provider.reset();
    Navigator.pop(context);
  }

  Widget _outputPercentages(GameStateProvider gameStateProvider) {
    List<Widget> percentages = [];
    gameStateProvider.optionCounters.forEach((opt, tuple) => percentages.add(
        new Text(
            "${opt.toString().split('.')[1].toLowerCase()}: ${gameStateProvider.getCorrectPercentage(opt).toString()} %")));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: percentages),
    );
  }

  @override
  Widget build(BuildContext context) {
    GameStateProvider gameStateProvider =
        Provider.of<GameStateProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("N-Back"),
        centerTitle: true,
      ),
      body: Column(
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
            _makeRoundResultChart(gameStateProvider),
            _outputPercentages(gameStateProvider),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: RaisedButton(
                  onPressed: () => _reset(context),
                  child: Text("PLAY AGAIN!"),
                ),
              ),
            )
          ]),
    );
  }
}

class _RoundResults {
  String option;
  double percent;

  _RoundResults(this.option, this.percent);
}
