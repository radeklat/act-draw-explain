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
  questionIDs: UnmodifiableListView([1, 2, 3]),
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
    [Question(id: 1, text: "q1"), Question(id: 2, text: "q2"), Question(id: 3, text: "q3")],
    key: (question) => question.id,
    value: (question) => question,
  ),
);

void main() {
  group('ScoreController', () {
    testWidgets('should generate next question text', (WidgetTester tester) async {
      String nextQuestion;
      ScoreController sc = ScoreController(
        topic: fakeTopic,
        questions: fakeQuestions,
        onNextQuestion: (str) {
          nextQuestion = str;
        },
      );

      sc.nextQuestion(passed: true);

      assert(nextQuestion != null);
      assert(nextQuestion.length > 0);
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
      assert(_playGame(answers: [true], maxQuestions: 1) != null);
    });

    testWidgets('should not end game when there are more questions', (WidgetTester tester) async {
      assert(_playGame(answers: [true, false]) == null);
    });

    testWidgets('should end game when there are no more questions', (WidgetTester tester) async {
      assert(_playGame() != null);
    });

    testWidgets('should treat 0 maxQuestions as all questions', (WidgetTester tester) async {
      assert(_playGame(maxQuestions: 0).questionsCount == fakeQuestions.length);
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

      assert(result != null);
      assert(result.questionsCount == 0);
      assert(result.score == 0);
    });
  });
}
