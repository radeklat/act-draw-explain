// Import the test package and Counter class
import 'package:act_draw_explain/data/questions.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/models/question.dart';
import 'package:test/test.dart';

void main() {
  group('Questions', () {
    test('should have a closing bracket when there is an opening one', () {
      for (Question question in questions.values) {
        if (question.text.contains("(")) {
          expect(question.text, contains(")"), reason: question.text);
        }
      }
    });

    test('should no have duplicates', () {
      Set<String> questionTexts = Set();
      Map<String, int> duplicates = {};
      Set<String> exceptions = {"Lov"};

      for (Question question in questions.values) {
        if (exceptions.contains(question.text)) continue;
        if (questionTexts.contains(question.text)) {
          duplicates.update(question.text, (value) => value+1, ifAbsent: () => 2);
        }
        questionTexts.add(question.text);
      }

      expect(duplicates, isEmpty, reason: "Listed items appear more than once.");
    });

    test('should should belong to at least one topic', () {
      Set<int> allTopicIDs = {};
      topics.values.map((topic) => allTopicIDs.addAll(topic.questionIDs)).toList();

      Set<int> allQuestionIDs = {};
      questions.values.map((question) => allQuestionIDs.add(question.id)).toList();

      expect(allQuestionIDs.difference(allTopicIDs), isEmpty);
    });
  });
}
