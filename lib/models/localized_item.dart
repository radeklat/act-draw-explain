import 'dart:collection';

import 'package:act_draw_explain/utilities/logging.dart';
import 'package:xml/xml.dart';

abstract class LocalizedItem {
  static const DISABLED = "DISABLED";
  final int id = null;
  final String baseText;
  final _log = Logger("LocalizedItem");
  HashMap<String, String> localizedTexts = HashMap();

  LocalizedItem(this.baseText);

  String text(String languageCode) {
    _log.when(!localizedTexts.containsKey(languageCode)).error("'$this' does not exist in '$languageCode'");
    _log.when(localizedTexts[languageCode] == null).error("'$this' is set to 'null' in '$languageCode'");
    return localizedTexts[languageCode];
  }

  bool isDisabled(String languageCode) {
    String itemText = text(languageCode);
    // Explicitly disabled or missing translation
    return itemText == DISABLED || itemText == "";
  }

  /// itemJson is a "trans-unit" from "<TYPE>/<LOCALE>.xliff"
  updateWithLocalizedXmlElement(XmlElement xmlItem, String languageCode) {
    localizedTexts[languageCode] = xmlItem.findElements("target").first.text;
  }

  /// topicJSON is a "trans-unit" from "<TYPE>.xliff" or "<TYPE>/<LOCALE>.xliff"
  static int idFromXmlElement(XmlElement xmlItem) {
    return int.parse(xmlItem.getAttribute("id"));
  }

  @override
  String toString() {
    return "$id: $baseText";
  }
}
