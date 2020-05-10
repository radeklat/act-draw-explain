import 'package:act_draw_explain/models/game_result.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'models/question.dart';
import 'models/topic.dart';

enum QuestionState { pass, fail, timeout }

class Analytics {
  final FirebaseAnalytics analytics;

  Analytics(this.analytics);

  void playedQuestion(Topic topic, Question question, Duration duration, QuestionState state, Duration timeLimit) async {
    await analytics.logEvent(
      name: 'playedQuestion',
      parameters: <String, dynamic>{
        'topicID': topic.id,
        'topicName': topic.name,
        'questionID': question.id,
        'questionText': question.text,
        'durationSeconds': duration.inMilliseconds / 1000,
        'state': state.toString().replaceFirst((QuestionState).toString() + ".", ""),
        'timeLimitSeconds': timeLimit.inSeconds,
      },
    );
  }

  void playedGame(Topic topic, Duration timeLimit, GameResult gameResult) async {
    await analytics.logEvent(
      name: 'playedGame',
      parameters: <String, dynamic>{
        'topicID': topic.id,
        'topicName': topic.name,
        'timeLimitSeconds': timeLimit.inSeconds,
        ...gameResult.toMap(),
      },
    );
  }
}
