import 'dart:collection';
import 'dart:convert';

import 'package:act_draw_explain/utilities/iter.dart';
import 'package:flutter/services.dart';
import 'package:xml2json/xml2json.dart';

UnmodifiableListView<String> _SUPPORTED_LOCALES = UnmodifiableListView(["cs", "en"]);

/// Returns XLIFF document as JSON in Badgerfish Convention
/// See: http://wiki.open311.org/JSON_and_XML_Conversion/
Future<Map<String, dynamic>> _loadXliffAssetAsJson(String type, [String locale]) async {
  locale = (locale == null) ? "" : "/$locale";
  String xmlContent = await rootBundle.loadString('assets/data/$type$locale.xliff');
  var xmlToJson = Xml2Json();
  xmlToJson.parse(xmlContent);
  return jsonDecode(xmlToJson.toBadgerfish());
}

Future<Map<int, Item>> loadTranslationFile<Item extends LocalizedItem>(
  String baseFileName,
  Function itemFromJson,
  Function idFromJson,
) async {
  Map<String, dynamic> _jsonRoot = await _loadXliffAssetAsJson(baseFileName);
  Map<int, Item> items = {};

  ensureList(_jsonRoot["xliff"]["file"]["body"]["trans-unit"]).forEach(
    (itemJson) {
      Item item = itemFromJson(itemJson);
      items[item.id] = item;
    },
  );

  _SUPPORTED_LOCALES.forEach(
    (String locale) async {
      Map<String, dynamic> localizedItemJson = await _loadXliffAssetAsJson(baseFileName, locale);
      Map<String, dynamic> file = localizedItemJson["xliff"]["file"];
      ensureList(file["body"]["trans-unit"]).forEach(
        (itemJson) {
          items[idFromJson(itemJson)].updateWithLocalizedJSON(itemJson, file["@target-language"]);
        },
      );
    },
  );

  return items;
}

class LocalizedItem {
  final int id = null;
  HashMap<String, String> localizedNames = HashMap();

  /// topicJSON is a "trans-unit" from "topics/<LOCALE>.xliff"
  updateWithLocalizedJSON(Map<String, dynamic> topicJson, String locale) {}
}
