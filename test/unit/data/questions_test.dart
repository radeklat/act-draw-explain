// Import the test package and Counter class
import 'package:act_draw_explain/models/game/data.dart';
import 'package:act_draw_explain/models/localized_item.dart';
import 'package:test/test.dart';

import '../../utils/game_data.dart';

void main() {
  group('Questions', () {
    setUpAll(() async {
      var loader = LocalAssetLoader();
      await GameData.initialize(loader.supportedLocales, loader);
    });

    test('should should not be empty', () async {
      expect(GameData.questions, isNotEmpty);
    });

    test('should have a closing bracket when there is an opening one', () {
      GameData.questions.values.forEach((question) {
        question.localizedTexts.forEach((language, text) {
          if (text.contains("(")) {
            expect(text, contains(")"), reason: "$language: $text");
          }
        });
      });
    });

    test('should not have duplicates', () {
      Set<String> questionTexts = Set();
      Map<String, int> duplicates = {};
      Map<String, int> exceptions = {"cs/Lov": 2, "cs/Kofola": 2, "en/Turkey": 2, "en/Reading": 2};

      GameData.questions.values.forEach((question) {
        question.localizedTexts.forEach((language, text) {
          String localisedText = "$language/$text";

          if (text != LocalizedItem.DISABLED && text != "") {
            if (questionTexts.contains(localisedText)) {
              duplicates.update(localisedText, (value) => value + 1, ifAbsent: () => 2);
            }
            questionTexts.add(localisedText);
          }
        });
      });

      exceptions.forEach((key, value) {
        if (duplicates[key] == value) {
          duplicates.remove(key);
        }
      });

      expect(duplicates, isEmpty, reason: "Listed items appear more than once.");
    });

    test('should should belong to at least one topic', () {
      Set<int> allTopicIDs = {};
      GameData.topics.values.forEach((topic) => allTopicIDs.addAll(topic.questions.keys));

      Set<int> allQuestionIDs = {};
      GameData.questions.values.forEach((question) => allQuestionIDs.add(question.id));

      expect(allQuestionIDs.difference(allTopicIDs), isEmpty);
    });
  });
}
