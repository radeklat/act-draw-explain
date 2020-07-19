import 'package:act_draw_explain/models/localized_item.dart';
import 'package:act_draw_explain/models/question.dart';
import 'package:test/test.dart';

import '../../utils/fakers.dart';
import '../../widget/controllers/score_test.dart';

void main() {
  group('Question', () {
    Question question;

    setUp(() {
      question = fakeQuestion(1, localisations: {"en": "enabled", "cs": LocalizedItem.DISABLED});
    });

    group('should identify disabled question for', () {
      test("enabled translation", () => expect(question.isDisabled("en"), false));
      test("disabled translation", () => expect(question.isDisabled("cs"), true));
    });

    group('should return correct translation for', () {
      test("enabled translation", () => expect(question.text("en"), "enabled"));
      test("disabled translation", () => expect(question.text("cs"), LocalizedItem.DISABLED));
    });
  });
}
