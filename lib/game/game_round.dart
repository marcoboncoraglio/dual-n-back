import 'dart:math';

import 'package:dualnback/game/auditory_input.dart';
import 'package:dualnback/game/visual_input.dart';
import 'package:flutter/material.dart';

import './game_state_provider.dart';

//TODO: refactor index in visualInput, looks bad outside
class GameRound {
  GameRound() {
    visualInput = new VisualInput(BoxShape.rectangle, Colors.black);
    auditoryInput = new AuditoryInput();
    index = new Random().nextInt(9);
  }

  VisualInput visualInput;
  AuditoryInput auditoryInput;
  int index;

  Map<MatchOption, bool> pressed = {
    MatchOption.POSITION: false,
    MatchOption.SOUND: false
  };
}
