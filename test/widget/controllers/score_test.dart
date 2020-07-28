import 'dart:collection';

import 'package:act_draw_explain/analytics.dart';
import 'package:act_draw_explain/constants.dart';
import 'package:act_draw_explain/controllers/score.dart';
import 'package:act_draw_explain/models/game/new.dart';
import 'package:act_draw_explain/models/game/result.dart';
import 'package:act_draw_explain/models/question.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/fakers.dart';

HashMap<int, Question> fakeQuestions = HashMap.fromEntries(
  List.generate(4, (index) => MapEntry(index, fakeQuestion(index))),
);
Topic fakeNonEmptyTopic = fakeTopic(questions: fakeQuestions);
Topic fakeEmptyTopic = fakeTopic();

void main() {
  group('ScoreController', () {
    testWidgets('should generate next question text', (WidgetTester tester) async {
      String nextQuestion;
      var sc = ScoreController(
        topic: fakeNonEmptyTopic,
        activities: GameMode.ACTIVITY,
        locale: Locale(K.settings.languageCode.defaultValue),
        onNextQuestion: (str, _activity) {
          nextQuestion = str;
        },
      );

      sc.nextQuestion(passed: true);

      expect(nextQuestion, isNotNull, reason: "nextQuestion");
      expect(nextQuestion.length, isPositive, reason: "nextQuestion.length");
    });

    testWidgets('should generate next activity type', (WidgetTester tester) async {
      var iterations = 20;
      Set<Activity> recordedActivities = {};
      var sc = ScoreController(
        topic: fakeTopic(
          questions: HashMap.fromEntries(
            List.generate(
              iterations,
              (index) => MapEntry(index, fakeQuestion(index)),
            ),
          ),
        ),
        activities: GameMode.ACTIVITY,
        locale: Locale(K.settings.languageCode.defaultValue),
        onNextQuestion: (_str, activity) {
          recordedActivities.add(activity);
        },
      );

      for (int i = 0; i <= iterations; i++) {
        sc.nextQuestion(passed: true);
      }

      expect(recordedActivities, GameMode.ACTIVITY, reason: "all activities should be recorded");
    });

    GameResult _playGame({List<bool> answers, int maxQuestions}) {
      if (answers == null) answers = List.generate(fakeQuestions.length, (_) => true);
      GameResult result;
      ScoreController sc = ScoreController(
        topic: fakeNonEmptyTopic,
        activities: GameMode.ACTIVITY,
        locale: Locale(K.settings.languageCode.defaultValue),
        onGameEnd: (gameResult) {
          result = gameResult;
        },
        maxQuestions: maxQuestions,
      );

      answers.map((value) => sc.nextQuestion(passed: value)).toList();
      return result;
    }

    testWidgets('should end game when maxQuestions is reached', (WidgetTester tester) async {
      expect(_playGame(answers: [true], maxQuestions: 1), isNotNull);
    });

    testWidgets('should not end game when there are more questions', (WidgetTester tester) async {
      expect(_playGame(answers: [true, false]), isNull);
    });

    testWidgets('should end game when there are no more questions', (WidgetTester tester) async {
      expect(_playGame(), isNotNull);
    });

    testWidgets('should treat 0 maxQuestions as all questions', (WidgetTester tester) async {
      expect(_playGame(maxQuestions: 0).questionsCount, fakeQuestions.length);
    });

    testWidgets('should end game immediately when topic has no questions', (WidgetTester tester) async {
      GameResult result;
      ScoreController(
        topic: fakeEmptyTopic,
        activities: GameMode.ACTIVITY,
        locale: Locale(K.settings.languageCode.defaultValue),
        onGameEnd: (gameResult) {
          result = gameResult;
        },
      );

      expect(result, GameResult(0, 0, 0, false));
    });

    testWidgets('should return current score when game is ended externally', (WidgetTester tester) async {
      GameResult result;
      ScoreController(
        topic: fakeNonEmptyTopic,
        activities: GameMode.ACTIVITY,
        locale: Locale(K.settings.languageCode.defaultValue),
        onGameEnd: (gameResult) {
          result = gameResult;
        },
      )
        ..nextQuestion(passed: true)
        ..endGame();

      expect(result, GameResult(fakeQuestions.length, 1, 1, true));
    });

    testWidgets('should expose if it has more questions', (WidgetTester tester) async {
      ScoreController sc = ScoreController(
        topic: fakeNonEmptyTopic,
        activities: GameMode.ACTIVITY,
        locale: Locale(K.settings.languageCode.defaultValue),
      );
      List.generate(fakeQuestions.length - 1, (index) {
        expect(sc.hasMoreQuestions, true, reason: "hasMoreQuestions during round ${index + 1}/${fakeQuestions.length}");
        sc.nextQuestion(passed: true);
      });

      expect(sc.hasMoreQuestions, false, reason: "hasMoreQuestions at the end");
    });

    testWidgets('should log each answered question', (WidgetTester tester) async {
      int logsCount = 0;
      QuestionState expectedState = QuestionState.pass;
      ScoreController sc = ScoreController(
        topic: fakeNonEmptyTopic,
        activities: GameMode.ACTIVITY,
        locale: Locale(K.settings.languageCode.defaultValue),
        logQuestion: (Topic t, Question q, Duration d, QuestionState qs) {
          expect(t, fakeNonEmptyTopic, reason: "Topic in $expectedState");
          expect(q, isIn(fakeQuestions.values), reason: "Question in $expectedState");
          expect(d.inMicroseconds, isPositive, reason: "Duration in $expectedState");
          expect(qs, expectedState, reason: "QuestionState");
          logsCount++;
        },
      );

      sc.nextQuestion(passed: true);
      expectedState = QuestionState.fail;
      sc.nextQuestion(passed: false);
      expectedState = QuestionState.timeout;
      sc.endGame();
      expect(logsCount, 3, reason: "log count");
    });
  });

  group('GameSounds', () {
    testWidgets('can have multiple instances', (WidgetTester tester) async {
      GameSounds();
      GameSounds();
    });

    group('can play sound for', () {
      testCase(Function func) {
        String functionName = func.toString().split(" ").last.replaceAll(RegExp(r"[':.]"), "");
        testWidgets(functionName, (WidgetTester tester) async {
          func();
        });
      }

      testCase(GameSounds().correct);
      testCase(GameSounds().wrong);
      testCase(GameSounds().timerTick);
      testCase(GameSounds().gameStart);
      testCase(GameSounds().gameEnd);
    });
  });
}
