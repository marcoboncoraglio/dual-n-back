import 'package:dualnback/game/statistics_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tuple/tuple.dart';

import 'game/game_state_provider.dart';

class StatisticsDB {
  // Singleton
  StatisticsDB._();
  static final StatisticsDB dbProvider = StatisticsDB._();

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
        version: 2,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Records ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "level INTEGER,"
              "date DATETIME"
              ")");
          await db.execute("CREATE TABLE OptionCounters ("
              "counterId INTEGER PRIMARY KEY AUTOINCREMENT,"
              "recordId INTEGER,"
              "percentage REAL,"
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
        "INSERT INTO OptionCounters (recordId, percentage, option)"
        " VALUES ($key, ${StatisticsUtil.getCorrectPercentage(opt, optionCounters)}, '${opt.toString()}')"));
  }

  Future<List> getByLevel(int level) async {
    final db = await database;
    var result = await db.rawQuery(
        "SELECT * FROM Records INNER JOIN OptionCounters ON Records.id = OptionCounters.recordId WHERE Records.level=$level");
    
    return result;
  }
}
