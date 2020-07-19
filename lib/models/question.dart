import 'package:act_draw_explain/models/translation_file.dart';
import 'package:xml/xml.dart';

class Question extends LocalizedItem {
  final int id;

  Question({this.id, String baseText}) : super(baseText);

  /// questionJson is a "trans-unit" from "topics.xliff"
  static Question fromXmlElement(XmlElement xmlQuestion) {
    return Question(
      id: LocalizedItem.idFromXmlElement(xmlQuestion),
      baseText: xmlQuestion.findElements("source").first.text,
    );
  }
}
