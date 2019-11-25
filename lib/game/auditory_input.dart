import 'dart:math';

import 'package:flutter_tts/flutter_tts.dart';

class AuditoryInput {
  AuditoryInput() {
    letter = possibleLetters[new Random().nextInt(possibleLetters.length)];
  }

  String letter;
  List<String> possibleLetters = ["b", "f", "h", "l", "i", "k", "m", "o"];

  static FlutterTts tts = _initTts();
  static double speechVolume = 99;

  static FlutterTts _initTts() {
    tts = new FlutterTts();
    tts.setSpeechRate(0.8);
    tts.setVolume(speechVolume);
    return tts;
  }

  speak(){
    tts.speak(letter);
  }

  static setSpeechVolume(double vol){
    speechVolume = vol;
    tts.setVolume(speechVolume);
  }
}
