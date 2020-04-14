import 'package:act_draw_explain/data/questions.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/models/game_result.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/utilities/vibrations.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class ScoreController {
  List<int> _questionIDs;
  Topic _topic;
  int _currentQuestionID;
  int _score = 0;
  Function(int) setNewScore;

  GameSounds _sounds = GameSounds();

  Function(String) onNextQuestion;
  Function(GameResult) onGameEnd;

  ScoreController({
    @required topicID,
    @required this.onNextQuestion,
    @required this.onGameEnd,
    @required this.setNewScore,
  }) {
    _topic = topics[topicID];
    _questionIDs = _topic.asShuffledQuestionIDs();

    try {
      _currentQuestionID = _questionIDs.removeLast();
    } on RangeError {
      endGame(newScore: 0);
      return;
    }

    onNextQuestion(questions[_currentQuestionID].text);
  }

  void endGame({int newScore}) {
    if (newScore == null) {
      newScore = _score;
    }

    setNewScore(newScore);
    GameVibrations.gameEnd();
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

    (passed) ? _sounds.playCorrect() : _sounds.playWrong();
    GameVibrations.answer();
    _score = newScore;
    _currentQuestionID = newQuestionID;
    onNextQuestion(questions[_currentQuestionID].text);
  }

  bool get hasMoreQuestions {
    return _questionIDs.length > 0;
  }
}

class GameSounds {
  static const String CORRECT = "correct_coin.mp3";
  static const String WRONG = "wrong_buzzer.mp3";

  static AudioCache _audioPlayer = AudioCache(
    fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY),
    prefix: "sounds/",
  );

  GameSounds() {
    _audioPlayer.load(CORRECT);
    _audioPlayer.load(WRONG);
  }

  void playCorrect() {
    _audioPlayer.play(CORRECT);
  }

  void playWrong() {
    _audioPlayer.play(WRONG);
  }
}
