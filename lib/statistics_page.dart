import 'package:dualnback/game/game_state_provider.dart';
import 'package:dualnback/statistics_db.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  Future<Widget> _makeRoundResultChart(int level) async {
    List<charts.Series<_RoundResults, DateTime>> seriesList = [];

    List<_RoundResults> list =
        await _RoundResults.fromMap(StatisticsDB.dbProvider.getByLevel(level));

    Map<MatchOption, List<_RoundResults>> map = {
      MatchOption.POSITION : new List<_RoundResults>(),
      MatchOption.SOUND : new List<_RoundResults>(),
      /* MatchOption.SHAPE : new List<_RoundResults>(),
      MatchOption.COLOR : new List<_RoundResults>() */
    };
    
    // ugly :(
    list.forEach((item) => {
          if (item.option == "MatchOption.POSITION")
            map[MatchOption.POSITION].add(item)
          else if (item.option == "MatchOption.SOUND")
            map[MatchOption.SOUND].add(item)
/*           else if (item.option == "MatchOption.COLOR")
            map[MatchOption.COLOR].add(item)
          else if (item.option == "MatchOption.SHAPE")
            map[MatchOption.SHAPE].add(item) */
        });

    map.forEach((opt, list) => seriesList.add(
        charts.Series<_RoundResults, DateTime>(
            id: opt.toString().split('.')[1].toLowerCase(),
            data: list,
            domainFn: (i, j) => i.date,
            measureFn: (i, j) => i.percent)));

    return SizedBox(
      height: 250,
      child: charts.TimeSeriesChart(
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
        behaviors: [charts.SeriesLegend()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        FutureBuilder(
          future: _makeRoundResultChart(1),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: Text('Loading...'));
              case ConnectionState.done:
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                return snapshot.data;
            }
            return null; // unreachable
          },
        )

      ],
    );
  }
}

class _RoundResults {
  String option;
  double percent;
  DateTime date;

  static Future<List<_RoundResults>> fromMap(Future<List> dbQuery) async {
    List<Map<String, dynamic>> query = await dbQuery;
    return List.generate(query.length, (i) {
      return _RoundResults(query[i]['option'], query[i]['percentage'],
          DateTime.parse(query[i]['date']));
    });
  }

  _RoundResults(this.option, this.percent, this.date);
}
