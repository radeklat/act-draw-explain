import 'dart:math';
import 'dart:ui';

import 'package:act_draw_explain/analytics.dart';
import 'package:act_draw_explain/models/game/new.dart';
import 'package:act_draw_explain/models/game/result.dart';
import 'package:act_draw_explain/models/question.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/utilities/vibrations.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class ScoreController {
  final Topic topic;
  final Locale locale;
  final Function(String, Activity)? onNextQuestion;
  final Function(GameResult)? onGameEnd;
  final Function(int)? setNewScore;
  final Function(Topic, Question, Duration, QuestionState)? logQuestion;

  final Random _random = Random();
  late List<Question> _shuffledQuestions;
  late List<Activity> _activities;
  late Question _currentQuestion;
  Stopwatch _stopwatch = Stopwatch();
  int _score = 0;

  late int _maxQuestions;

  static GameSounds gameSounds = GameSounds();

  ScoreController({
    required this.topic,
    required this.locale,
    required activities,
    this.onNextQuestion,
    this.onGameEnd,
    this.setNewScore,
    this.logQuestion,
    maxQuestions,
  }) {
    _shuffledQuestions = topic.shuffledQuestions(locale);
    _maxQuestions = min(((maxQuestions ?? 0) == 0) ? _shuffledQuestions.length : maxQuestions, _shuffledQuestions.length);
    _shuffledQuestions = _shuffledQuestions.sublist(0, _maxQuestions);
    _activities = List.from(activities);

    try {
      _currentQuestion = _shuffledQuestions.removeLast();
    } on RangeError {
      _endGame(newScore: 0);
      return;
    }

    onNextQuestion?.call(_currentQuestion.text(locale), _randomActivity());
    _stopwatch.start();
  }

  Activity _randomActivity() {
    return _activities[_random.nextInt(_activities.length)];
  }

  void endGame() => _endGame();

  void _endGame({int? newScore}) {
    bool timeOut = false;
    int questionsGuessed = _maxQuestions - _shuffledQuestions.length;

    if (newScore == null) {
      newScore = _score;
      questionsGuessed -= 1;
      timeOut = true;
      logQuestion?.call(topic, _currentQuestion, _stopwatch.elapsed, QuestionState.timeout);
    }

    setNewScore?.call(newScore);
    gameSounds.gameEnd();
    GameVibrations.gameEnd();
    _stopwatch.stop();
    onGameEnd?.call(GameResult(_maxQuestions, questionsGuessed, newScore, timeOut));
  }

  void nextQuestion({required bool passed}) {
    int newScore = (passed) ? _score + 1 : _score;
    Question newQuestion;

    logQuestion?.call(
      topic,
      _currentQuestion,
      _stopwatch.elapsed,
      (passed) ? QuestionState.pass : QuestionState.fail,
    );

    try {
      newQuestion = _shuffledQuestions.removeLast();
    } on RangeError {
      _endGame(newScore: newScore);
      return;
    }

    (passed) ? gameSounds.correct() : gameSounds.wrong();
    GameVibrations.answer();
    _score = newScore;
    _currentQuestion = newQuestion;
    _stopwatch.reset();
    onNextQuestion?.call(_currentQuestion.text(locale), _randomActivity());
  }

  bool get hasMoreQuestions {
    return _shuffledQuestions.length > 0;
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
    prefix: "assets/sounds/",
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
