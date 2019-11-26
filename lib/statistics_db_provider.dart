import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tuple/tuple.dart';

import 'game/game_state_provider.dart';

class StatisticsProvider with ChangeNotifier {
  // Singleton
  StatisticsProvider._();
  static final StatisticsProvider dbProvider = StatisticsProvider._();

  static Database _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    String dbPath = join(dir.path, 'settingsDB.db');

    return await openDatabase(dbPath,
        version: 1,
        onOpen: (db) => print("Database opened"),
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Records ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "level INTEGER,"
              "date DATETIME"
              ")");
          await db.execute("CREATE TABLE OptionCounters ("
              "counterId INTEGER PRIMARY KEY AUTOINCREMENT,"
              "recordId INTEGER,"
              "possible INTEGER,"
              "correct INTEGER,"
              "wrong INTEGER,"
              "option STRING,"
              "FOREIGN KEY (recordId) REFERENCES Records(id)"
              ")");
        });
  }

  void insertRecord(
      Map<MatchOption, Tuple3<int, int, int>> optionCounters, int level) async {
    final db = await database;

    int key = await db.rawInsert("INSERT into Records (level,date)"
        " VALUES ($level,datetime('now'))");

    optionCounters.forEach((opt, tuple) => db.rawInsert(
        "INSERT INTO OptionCounters (recordId, possible, correct, wrong, option)"
        " VALUES ($key, ${tuple.item1}, ${tuple.item2}, ${tuple.item3}, '${opt.toString()}')"));
  }

  void getByLevel(int level) async {
    final db = await database;
    var result = db.rawQuery(
        "SELECT * FROM Records INNER JOIN OptionCounters ON Records.id = OptionCounters.recordId WHERE Records.level=$level");
    print(await result);
  }

  void removeAll() async {
    final db = await database;
    db.rawQuery("DELETE FROM Records");
    db.rawQuery("DELETE FROM OptionCounters");
  }
}
