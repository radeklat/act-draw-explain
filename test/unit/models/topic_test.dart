import 'dart:collection';

import 'package:act_draw_explain/models/localized_item.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:test/test.dart';

import '../../utils/constants.dart';
import '../../utils/fakers.dart';

void main() {
  group('Topic', () {
    Topic topic;

    group('should not produce disabled question', () {
      setUp(() {
        topic = fakeTopic(
          questions: HashMap.from({
            1: fakeQuestion(1, localisations: {"en": "enabled en", "cs": LocalizedItem.DISABLED}),
            2: fakeQuestion(2, localisations: {"en": "enabled en", "cs": "enabled cs"}),
            3: fakeQuestion(3, localisations: {"en": LocalizedItem.DISABLED, "cs": "enabled cs"}),
          }),
          localisations: {"en": "enabled en", "cs": "enabled cs"},
        );
      });

      test("en", () => expect(topic.shuffledQuestions(EN).map((question) => question.id).toSet(), {1, 2}));
      test("cs", () => expect(topic.shuffledQuestions(CS).map((question) => question.id).toSet(), {2, 3}));
    });

    test('should not produce questions from hidden packages', () {
      topic = fakeTopic(
        questions: HashMap.from({1: fakeQuestion(1), 2: fakeQuestion(2), 3: fakeQuestion(3)}),
        packages: {1: [1,2], 2: [3]},
      );
      topic.setEnabledPackages({1});

      expect(topic.shuffledQuestions(EN).map((question) => question.id).toSet(), {1, 2});
    });

    group('should identify topics ', () {
      setUp(() {
        topic = fakeTopic(
          questions: HashMap.from({
            1: fakeQuestion(1, localisations: {"en": "enabled en", "cs": "enabled cs", "de": LocalizedItem.DISABLED}),
          }),
          localisations: {"en": "enabled en", "cs": LocalizedItem.DISABLED, "de": "enabled de"},
        );
      });

      test("enabled by name", () => expect(topic.isDisabled(EN), false));
      test("disabled by name", () => expect(topic.isDisabled(CS), true));
      test("disabled by not having any enabled question", () => expect(topic.isDisabled(DE), true));
    });
  });
}
