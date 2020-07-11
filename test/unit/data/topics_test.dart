// Import the test package and Counter class
import 'package:act_draw_explain/models/game.dart';
import 'package:test/test.dart';

import '../../mock_data.dart';

void main() {
  group('Topics', () {
    setUpAll(() async {
      await GameData.initialize(LocalAssetLoader());
    });

    test('should should not be empty', () async {
      expect(GameData.topics, isNotEmpty);
    });

    test('should contain only existing questions', () {
      Set<int> allTopicIDs = {};
      GameData.topics.values.map((topic) => allTopicIDs.addAll(topic.questionIDs)).toList();

      Set<int> allQuestionIDs = {};
      GameData.questions.values.map((question) => allQuestionIDs.add(question.id)).toList();

      expect(allTopicIDs.difference(allQuestionIDs), isEmpty);
    });
  });
}
