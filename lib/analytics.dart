import 'package:firebase_analytics/firebase_analytics.dart';

import 'models/question.dart';
import 'models/topic.dart';

enum QuestionState { pass, fail, timeout }

class Analytics {  
  final FirebaseAnalytics analytics;

  Analytics(this.analytics);

  void logQuestion(Topic topic, Question question, Duration duration, QuestionState state, Duration timeLimit) async {
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
}