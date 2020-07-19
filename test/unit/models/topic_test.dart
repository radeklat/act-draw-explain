import 'dart:collection';

import 'package:act_draw_explain/models/localized_item.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:test/test.dart';

import '../../utils/fakers.dart';

void main() {
  group('Topic', () {
    Topic topic;

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

    group('should identify disabled question', () {
      test("en", () => expect(topic.questionIDs("en"), [1, 2]));
      test("cs", () => expect(topic.questionIDs("cs"), [2, 3]));
    });
  });
}
