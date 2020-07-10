// Import the test package and Counter class
import 'package:act_draw_explain/data/questions.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:test/test.dart';

void main() {
  group('Topics', () {
    test('should contain only existing questions', () {
      Set<int> allTopicIDs = {};
      GameData.topics.values.map((topic) => allTopicIDs.addAll(topic.questionIDs)).toList();

      Set<int> allQuestionIDs = {};
      questions.values.map((question) => allQuestionIDs.add(question.id)).toList();

      expect(allTopicIDs.difference(allQuestionIDs), isEmpty);
    });
  });
}
