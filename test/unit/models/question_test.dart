import 'package:act_draw_explain/models/localized_item.dart';
import 'package:act_draw_explain/models/question.dart';
import 'package:test/test.dart';

import '../../widget/controllers/score_test.dart';

void main() {
  group('Question', () {
    Question question;

    setUp(() {
      question = fakeQuestion(1, localisations: {"en": "enabled", "cs": LocalizedItem.DISABLED});
    });

    test('should identify disabled question', () async {
      expect(question.isDisabled("en"), false, reason: "Question was expected to be enabled.");
      expect(question.isDisabled("cs"), true, reason: "Question was expected to be disabled.");
    });

    test('should return correct translation', () async {
      expect(question.text("en"), "enabled");
      expect(question.text("cs"), LocalizedItem.DISABLED);
    });
  });
}
