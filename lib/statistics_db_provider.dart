import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class LocalDBProvider with ChangeNotifier {
  /* final Future<Database> statisticsDatabase = openDatabase(
    join(await getDatabasesPath(), 'statistics_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE settings(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
      );
    },
    version: 1,
  ); */
}
