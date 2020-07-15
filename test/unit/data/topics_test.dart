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
      GameData.topics.values.forEach((topic) => allTopicIDs.addAll(topic.questions.keys));

      Set<int> allQuestionIDs = {};
      GameData.questions.values.forEach((question) => allQuestionIDs.add(question.id));

      expect(allTopicIDs.difference(allQuestionIDs), isEmpty);
    });

    test('should have a color', () {
      GameData.topics.values.forEach(
        (topic) => expect(
          topic.color,
          isNotNull,
          reason: "Topic ${topic.id} '${topic.text()}' has no or invalid color set",
        ),
      );
    });

    test('should have an icon', () {
      GameData.topics.values.forEach(
        (topic) => expect(
          topic.icon,
          isNotNull,
          reason: "Topic ${topic.id} '${topic.text()}' has no or invalid icon set",
        ),
      );
    });

    test('should contain some questions', () {
      GameData.topics.values.forEach(
        (topic) => expect(
          topic.questions.keys,
          isNotEmpty,
          reason: "Topic ${topic.id} '${topic.text()}' contains no questions IDs",
        ),
      );
    });
  });
}
