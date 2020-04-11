import 'package:act_draw_explain/data/questions.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/models/game_result.dart';
import 'package:act_draw_explain/models/results.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:flutter/foundation.dart';

class ScoreController {
  List<int> _questionIDs;
  Topic _topic;
  int _currentQuestionID;
  int _score = 0;

  Function(String) onNextQuestion;
  Function(GameResult) onGameEnd;

  ScoreController({@required topicID, @required this.onNextQuestion, @required this.onGameEnd}) {
    _topic = topics[topicID];
    _questionIDs = _topic.asShuffledQuestionIDs();
    nextQuestion(passed: false);
  }

  void endGame({int newScore}) {
    if (newScore == null) {
      newScore = _score;
    }

    Results.recordBestScore(topicID: _topic.id, newScore: newScore);
    onGameEnd(
      GameResult(questionsCount: _topic.questionIDs.length, score: _score),
    );
  }

  void nextQuestion({@required bool passed}) {
    int newScore = (passed) ? _score + 1 : _score;
    int newQuestionID;

    try {
      newQuestionID = _questionIDs.removeLast();
    } on RangeError {
      endGame(newScore: newScore);
      return;
    }

    _score = newScore;
    _currentQuestionID = newQuestionID;
    onNextQuestion(questions[_currentQuestionID].text);
  }
}
