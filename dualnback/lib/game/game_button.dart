import 'package:dualnback/game/auditory_input.dart';
import 'package:dualnback/game/visual_input.dart';

class GameButton {
  //id might not be necessary
  final id;
  final VisualInput visualInput;
  final AuditoryInput auditoryInput;
  bool enabled;

  GameButton(this.visualInput, this.auditoryInput,
      {this.id, this.enabled = true});
}
