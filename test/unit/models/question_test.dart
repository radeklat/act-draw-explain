import 'package:act_draw_explain/models/localized_item.dart';
import 'package:act_draw_explain/models/question.dart';
import 'package:test/test.dart';

import '../../utils/constants.dart';
import '../../utils/fakers.dart';

void main() {
  group('Question', () {
    Question question;

    setUp(() {
      question = fakeQuestion(1, localisations: {"en": "enabled", "cs": LocalizedItem.DISABLED});
    });

    group('should identify disabled question for', () {
      test("enabled translation", () => expect(question.isDisabled(EN), false));
      test("disabled translation", () => expect(question.isDisabled(CS), true));
    });

    group('should return correct translation for', () {
      test("enabled translation", () => expect(question.text(EN), "enabled"));
      test("disabled translation", () => expect(question.text(CS), LocalizedItem.DISABLED));
    });
  });
}
