import 'package:act_draw_explain/models/topic.dart';

class GameMode {
  static const Set<Activity> ACTIVITY = {Activity.act, Activity.draw, Activity.explain};
  static const Set<Activity> HEADS_UP = {Activity.explain};
}

enum Activity {
  act, draw, explain
}

class NewGame {
  final Topic topic;
  final Set<Activity> activities;
  final String screenId;

  NewGame(this.topic, this.activities, this.screenId);
}