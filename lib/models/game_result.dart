import 'package:equatable/equatable.dart';

class GameResult extends Equatable {
  final int questionsCount;
  final int questionsGuessed;
  final int score;
  final bool timeOut;

  const GameResult(this.questionsCount, this.questionsGuessed, this.score, this.timeOut);

  Map<String, dynamic> toMap() {
    return {
      "questionsCount": questionsCount,
      "questionsGuessed": questionsGuessed,
      "score": score,
      "successRate": (questionsGuessed > 0) ? score / questionsGuessed : 0.0,
      "timeOut": timeOut,
    };
  }

  @override
  List<Object> get props => [questionsCount, questionsGuessed, score, timeOut];

  @override
  String toString() {
    return "questionsCount: $questionsCount, questionsGuessed: $questionsGuessed, score: $score, timeOut: $timeOut";
  }
}
