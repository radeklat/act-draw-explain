import 'package:flutter/foundation.dart';

class GameResult {
  final int questionsCount;
  final int questionsGuessed;
  final int score;
  final bool timeOut;

  const GameResult({@required this.questionsCount, @required this.questionsGuessed, @required this.score, @required this.timeOut});

  Map<String, dynamic> toMap() {
    return {
      "questionsCount": questionsCount,
      "questionsGuessed": questionsGuessed,
      "score": score,
      "successRate": (questionsGuessed > 0) ? score / questionsGuessed : 0.0,
      "timeOut": timeOut,
    };
  }
}