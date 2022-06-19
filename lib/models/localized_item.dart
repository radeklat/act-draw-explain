import 'dart:collection';
import 'dart:ui';

import 'package:act_draw_explain/utilities/logging.dart';
import 'package:xml/xml.dart';

abstract class LocalizedItem {
  static const DISABLED = "DISABLED";
  late final int id;
  final String baseText;
  final _log = Logger("LocalizedItem");
  HashMap<Locale, String> localizedTexts = HashMap();

  LocalizedItem(this.baseText);

  String text(Locale locale) {
    _log.when(!localizedTexts.containsKey(locale)).error("'$this' does not exist in '$locale'");
    _log.when(localizedTexts[locale] == null).error("'$this' is set to 'null' in '$locale'");
    return localizedTexts[locale] ?? "<MISSING LOCALE>";
  }

  bool isDisabled(Locale locale) {
    String itemText = text(locale);
    // Explicitly disabled or missing translation
    return itemText == DISABLED || itemText == "";
  }

  /// itemJson is a "trans-unit" from "<TYPE>/<LOCALE>.xliff"
  updateWithLocalizedXmlElement(XmlElement xmlItem, Locale locale) {
    localizedTexts[locale] = xmlItem.findElements("target").first.text;
  }

  /// topicJSON is a "trans-unit" from "<TYPE>.xliff" or "<TYPE>/<LOCALE>.xliff"
  static int idFromXmlElement(XmlElement xmlItem) {
    var id = xmlItem.getAttribute("id");
    if (id == null) {
      throw Exception("Element is missing a required 'id' field.");
    } else {
      return int.parse(id);
    }
  }

  @override
  String toString() {
    return "$id: $baseText";
  }
}
