// Import the test package and Counter class
import 'package:act_draw_explain/models/game/data.dart';
import 'package:test/test.dart';

import '../../utils/constants.dart';
import '../../utils/game_data.dart';

void main() {
  group('Topics', () {
    setUpAll(() async {
      var loader = LocalAssetLoader();
      await GameData.initialize(loader.supportedLocales, loader);
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
          reason: "Topic '$topic' has no or invalid color set",
        ),
      );
    });

    test('should have an icon', () {
      GameData.topics.values.forEach(
        (topic) => expect(
          topic.icon,
          isNotNull,
          reason: "Topic '$topic' has no or invalid icon set",
        ),
      );
    });

    test('should contain some questions', () {
      GameData.topics.values.forEach(
        (topic) => expect(
          topic.questions.keys,
          isNotEmpty,
          reason: "Topic '$topic' contains no questions IDs",
        ),
      );
    });

    group('should have reasonable amount of questions visible for each language if enabled', () {
      const int minCnt = 15;
      const int maxCnt = 30;
      Map<String, int> minCntExceptions = {"13/cs": 11};

      AllLocales.forEach((locale) {
        test(locale.toString(), () {
          GameData.topics.values.where((topic) => !topic.isDisabled(locale)).forEach((topic) {
            int topicMinCnt = minCntExceptions["${topic.id}/$locale"] ?? minCnt;
            int topicLen = topic.length(locale);

            expect(
              topicLen,
              greaterThanOrEqualTo(topicMinCnt),
              reason: "Topic ${topic.id} ${topic.baseText} has less than $topicMinCnt questions visible.",
            );

            expect(
              topicLen,
              lessThanOrEqualTo(maxCnt),
              reason: "Topic ${topic.id} ${topic.baseText} has more than $maxCnt questions visible.",
            );
          });
        });
      });
    });
  });
}
