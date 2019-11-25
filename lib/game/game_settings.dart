import 'package:shared_preferences/shared_preferences.dart';

class GameSettings{

  static int level;
  static int timerInterval;
  static int totalRounds;
  static double speechVolume;

  static void init() async{
    final prefs = await SharedPreferences.getInstance();

    level = prefs.getInt('level') ?? 1;
    timerInterval = prefs.getInt('timerInterval') ?? 2000;
    totalRounds = prefs.getInt('totalRounds') ?? 20;
    speechVolume = prefs.getDouble('speechVolume') ?? 99;
  }

  static void save() async{
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('level', level);
    prefs.setInt('timerInterval', timerInterval);
    prefs.setInt('totalRounds', totalRounds);
    prefs.setDouble('speechVolume', speechVolume);
  }
}