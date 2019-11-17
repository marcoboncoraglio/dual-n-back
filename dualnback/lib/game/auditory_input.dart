import 'dart:math';

import 'package:flutter_tts/flutter_tts.dart';

class AuditoryInput {
  AuditoryInput() {
    letter = possibleLetters[new Random().nextInt(possibleLetters.length)];
  }

  String letter;
  List<String> possibleLetters = ["a", "b", "f", "h", "l", "i", "k", "m", "o"];
  static FlutterTts tts = new FlutterTts();

  speak(){
    tts.speak(letter);
  }
}
