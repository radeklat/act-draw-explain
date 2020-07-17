import 'package:act_draw_explain/models/translation_file.dart';

class Question extends LocalizedItem {
  final int id;

  Question({this.id, String baseText}) : super(baseText);

  /// questionJson is a "trans-unit" from "topics.xliff"
  static Question fromJson(Map<String, dynamic> questionJson) {
    return Question(id: LocalizedItem.idFromJson(questionJson), baseText: questionJson["source"]["\$"]);
  }
}
