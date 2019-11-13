import 'dart:math';

import 'package:dualnback/game/auditory_input.dart';
import 'package:dualnback/game/visual_input.dart';
import 'package:flutter/material.dart';

class GameRound{
  GameRound(){
    visualInput = new  VisualInput(BoxShape.rectangle, Colors.black);
    auditoryInput = new AuditoryInput();
    randomIndex = new Random().nextInt(9);
  }

  VisualInput visualInput;
  AuditoryInput auditoryInput;
  int randomIndex;
}