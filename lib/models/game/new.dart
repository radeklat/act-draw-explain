import 'package:act_draw_explain/models/topic.dart';

enum GameMode {
  act, draw, explain
}

class NewGame {
  final Topic topic;
  final Set<GameMode> modes;
  final String screenId;

  NewGame(this.topic, this.modes, this.screenId);
}