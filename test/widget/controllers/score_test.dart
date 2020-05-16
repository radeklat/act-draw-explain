import 'dart:collection';

import 'package:act_draw_explain/controllers/score.dart';
import 'package:act_draw_explain/models/game_result.dart';
import 'package:act_draw_explain/models/question.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Topic fakeTopic = Topic(
  id: 1,
  name: "Fake topic",
  color: Colors.black,
  icon: Icon(Icons.score),
  questionIDs: UnmodifiableListView([1, 2, 3, 4]),
);

Topic fakeEmptyTopic = Topic(
  id: fakeTopic.id,
  name: fakeTopic.name,
  color: fakeTopic.color,
  icon: fakeTopic.icon,
  questionIDs: UnmodifiableListView([]),
);

UnmodifiableMapView<int, Question> fakeQuestions = UnmodifiableMapView(
  Map.fromIterable(
    [
      Question(id: 1, text: "q1"),
      Question(id: 2, text: "q2"),
      Question(id: 3, text: "q3"),
      Question(id: 4, text: "q4")
    ],
    key: (question) => question.id,
    value: (question) => question,
  ),
);

void main() {
  group('ScoreController', () {
    testWidgets('should generate next question text', (WidgetTester tester) async {
      String nextQuestion;
      ScoreController(
        topic: fakeTopic,
        questions: fakeQuestions,
        onNextQuestion: (str) {
          nextQuestion = str;
        },
      ).nextQuestion(passed: true);

      expect(nextQuestion, isNotNull, reason: "nextQuestion");
      expect(nextQuestion.length, isPositive, reason: "nextQuestion.length");
    });

    GameResult _playGame({List<bool> answers, int maxQuestions}) {
      if (answers == null) answers = List.generate(fakeQuestions.length, (_) => true);
      GameResult result;
      ScoreController sc = ScoreController(
        topic: fakeTopic,
        questions: fakeQuestions,
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
        questions: fakeQuestions,
        onGameEnd: (gameResult) {
          result = gameResult;
        },
      );

      expect(result, GameResult(0, 0, 0, false));
    });

    testWidgets('should return current score when game is ended externally', (WidgetTester tester) async {
      GameResult result;
      ScoreController(
        topic: fakeTopic,
        questions: fakeQuestions,
        onGameEnd: (gameResult) {
          result = gameResult;
        },
      )
        ..nextQuestion(passed: true)
        ..endGame();

      expect(result, GameResult(fakeQuestions.length, 1, 1, true));
    });
  });
}
