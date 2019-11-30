import 'dart:math';

import 'package:dualnback/game/game_settings.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AuditoryInput {
  AuditoryInput() {
    letter = possibleLetters[new Random().nextInt(possibleLetters.length)];
  }

  String letter;
  List<String> possibleLetters = ["b", "f", "h", "l", "i", "k", "m", "o"];

  static FlutterTts tts = _initTts();

  static FlutterTts _initTts() {
    tts = new FlutterTts();
    tts.setSpeechRate(0.8);
    tts.setVolume(GameSettings.speechVolume);
    return tts;
  }

  speak(){
    tts.speak(letter);
  }

  static setSpeechVolume(){
    tts.setVolume(GameSettings.speechVolume/100);
  }
}
