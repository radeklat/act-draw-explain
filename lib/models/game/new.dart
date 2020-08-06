import 'package:act_draw_explain/generated/l10n.dart';
import 'package:act_draw_explain/models/topic.dart';

class GameMode {
  static const Set<Activity> ACTIVITY = {Activity.act, Activity.draw, Activity.explain};
  static const Set<Activity> HEADS_UP = {Activity.explain};
}

enum Activity {
  act, draw, explain
}

String activityToName(Activity activity, S s) {
  switch (activity) {
    case Activity.act: return s.activity_act;
    case Activity.draw: return s.activity_draw;
    case Activity.explain: return s.activity_explain;
  }
  return "";
}

class NewGame {
  final Topic topic;
  final Set<Activity> activities;
  final String screenId;

  NewGame(this.topic, this.activities, this.screenId);
}