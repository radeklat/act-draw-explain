import 'dart:ui';

import 'package:act_draw_explain/models/game/new.dart';
import 'package:act_draw_explain/models/game/result.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

import 'constants.dart';
import 'models/question.dart';
import 'models/topic.dart';

enum QuestionState { pass, fail, timeout }

class Analytics {
  final FirebaseAnalytics analytics;

  Analytics(this.analytics);

  void playedQuestion(
    Topic topic,
    Question question,
    Duration duration,
    QuestionState state,
    Duration timeLimit,
    String gameType, [
    Activity activity,
  ]) async {
    await analytics.logEvent(
      name: 'playedQuestion',
      parameters: <String, dynamic>{
        'topicID': topic.id,
        'topicName': topic.baseText,
        'questionID': question.id,
        'questionText': question.baseText,
        'durationSeconds': duration.inMilliseconds / 1000,
        'state': describeEnum(state),
        'timeLimitSeconds': timeLimit.inSeconds,
        'gameType': gameType,
        'activity_type': (activity == null) ? "N/A" : describeEnum(activity)
      },
    );
  }

  void playedGame(Topic topic, Duration timeLimit, GameResult gameResult) async {
    await analytics.logEvent(
      name: 'playedGame',
      parameters: <String, dynamic>{
        'topicID': topic.id,
        'topicName': topic.baseText,
        'timeLimitSeconds': timeLimit.inSeconds,
        ...gameResult.toMap(),
      },
    );
  }

  void settingsChanged(String key, Map<String, dynamic> allValues) async {
    await analytics.logEvent(
      name: 'settingsChanged',
      parameters: <String, dynamic>{'key': key, 'newValue': allValues[key], ...allValues},
    );
  }

  void userFeedback(FeedbackType type) async {
    await analytics.logEvent(
      name: 'feedback',
      parameters: <String, dynamic>{
        'type': describeEnum(type),
      },
    );
  }

  void brushColorChoice(Color color) async {
    await analytics.logEvent(
      name: 'paint_event',
      parameters: <String, dynamic>{
        'type': 'brush_color',
        'value': color.value
      },
    );
  }

  void brushSizeChoice(double size) async {
    await analytics.logEvent(
      name: 'paint_event',
      parameters: <String, dynamic>{
        'type': 'brush_size',
        'value': size
      },
    );
  }

  void clearCanvas() async {
    await analytics.logEvent(
      name: 'paint_event',
      parameters: <String, dynamic>{
        'type': 'clear_canvas'
      },
    );
  }

  void paintCanvas() async {
    await analytics.logEvent(
      name: 'paint_event',
      parameters: <String, dynamic>{
        'type': 'paint'
      },
    );
  }

  void _simpleEvent(String name) async {
    await analytics.logEvent(name: name);
  }

  void openedChangelog() {
    _simpleEvent("openedChangelog");
  }

  void clickedLink(String url) async {
    await analytics.logEvent(
      name: 'clickedLink',
      parameters: <String, dynamic>{
        'url': url,
      },
    );
  }
}
