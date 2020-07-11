import 'dart:collection';
import 'dart:math';

import 'package:act_draw_explain/analytics.dart';
import 'package:act_draw_explain/models/game_result.dart';
import 'package:act_draw_explain/models/question.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/utilities/vibrations.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class ScoreController {
  final Topic topic;
  final HashMap<int, Question> questions;
  List<int> _questionIDs;
  int _currentQuestionID;
  Stopwatch _stopwatch = Stopwatch();
  static GameSounds gameSounds = GameSounds();
  int _score = 0;
  int _maxQuestions;
  Function(int) setNewScore;

  Function(String) onNextQuestion;
  Function(GameResult) onGameEnd;
  Function(Topic, Question, Duration, QuestionState) logQuestion;

  ScoreController({
    @required this.topic,
    @required this.questions,
    this.onNextQuestion,
    this.onGameEnd,
    this.setNewScore,
    this.logQuestion,
    maxQuestions,
  }) {
    _questionIDs = topic.asShuffledQuestionIDs();
    _maxQuestions = min(((maxQuestions ?? 0) == 0) ? _questionIDs.length : maxQuestions, _questionIDs.length);
    _questionIDs = _questionIDs.sublist(0, _maxQuestions);

    try {
      _currentQuestionID = _questionIDs.removeLast();
    } on RangeError {
      _endGame(newScore: 0);
      return;
    }

    onNextQuestion?.call(questions[_currentQuestionID].text());
    _stopwatch.start();
  }

  void endGame() => _endGame();

  void _endGame({int newScore}) {
    bool timeOut = false;
    int questionsGuessed = _maxQuestions - _questionIDs.length;

    if (newScore == null) {
      newScore = _score;
      questionsGuessed -= 1;
      timeOut = true;
      logQuestion?.call(topic, questions[_currentQuestionID], _stopwatch.elapsed, QuestionState.timeout);
    }

    setNewScore?.call(newScore);
    gameSounds.gameEnd();
    GameVibrations.gameEnd();
    _stopwatch.stop();
    onGameEnd?.call(GameResult(_maxQuestions, questionsGuessed, newScore, timeOut));
  }

  void nextQuestion({@required bool passed}) {
    int newScore = (passed) ? _score + 1 : _score;
    int newQuestionID;

    logQuestion?.call(
      topic,
      questions[_currentQuestionID],
      _stopwatch.elapsed,
      (passed) ? QuestionState.pass : QuestionState.fail,
    );

    try {
      newQuestionID = _questionIDs.removeLast();
    } on RangeError {
      _endGame(newScore: newScore);
      return;
    }

    (passed) ? gameSounds.correct() : gameSounds.wrong();
    GameVibrations.answer();
    _score = newScore;
    _currentQuestionID = newQuestionID;
    _stopwatch.reset();
    onNextQuestion?.call(questions[_currentQuestionID].text());
  }

  bool get hasMoreQuestions {
    return _questionIDs.length > 0;
  }
}

class GameSounds {
  static const String _CORRECT = "correct_coin.mp3";
  static const String _WRONG = "wrong_buzzer.mp3";
  static const String _TICK = "tick.mp3";
  static const String _CHIME = "chime.mp3";
  static const String _WINNER = "winner.mp3";

  static AudioCache _audioPlayer = AudioCache(
    fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY),
    prefix: "sounds/",
  );
  static bool _initialised = false;

  GameSounds() {
    if (!_initialised) {
      [_CORRECT, _WRONG, _TICK, _CHIME, _WINNER].map((filename) => _audioPlayer.load(filename));
      _initialised = true;
    }
  }

  void correct() {
    _audioPlayer.play(_CORRECT);
  }

  void wrong() {
    _audioPlayer.play(_WRONG);
  }

  void timerTick() {
    _audioPlayer.play(_TICK);
  }

  void gameStart() {
    _audioPlayer.play(_CHIME);
  }

  void gameEnd() {
    _audioPlayer.play(_WINNER);
  }
}
