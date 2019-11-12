import 'package:dualnback/game/auditory_input.dart';
import 'package:dualnback/game/visual_input.dart';
import 'package:flutter/material.dart';

class GameRound{
  VisualInput visualInput = new  VisualInput(BoxShape.rectangle, Colors.black);
  AuditoryInput auditoryInput = new AuditoryInput();
}