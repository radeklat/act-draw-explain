import 'dart:collection';
import 'dart:convert';

import 'package:act_draw_explain/utilities/iter.dart';
import 'package:flutter/services.dart';
import 'package:xml2json/xml2json.dart';

import '../constants.dart';

// TODO: Replace with `localizationsDelegate.supportedLocales`
UnmodifiableListView<String> _supportedLocales = UnmodifiableListView(["cs", "en"]);

/// Returns XLIFF document as JSON in Badgerfish Convention
/// See: http://wiki.open311.org/JSON_and_XML_Conversion/
Future<Map<String, dynamic>> _loadXliffAssetAsJson(String type, [String locale]) async {
  locale = (locale == null) ? "" : "/$locale";
  String xmlContent = await rootBundle.loadString('assets/data/$type$locale.xliff');
  var xmlToJson = Xml2Json();
  xmlToJson.parse(xmlContent);
  return jsonDecode(xmlToJson.toBadgerfish());
}

Future<HashMap<int, Item>> loadTranslationFile<Item extends LocalizedItem>(
  String baseFileName,
  Function itemFromJson,
  Function idFromJson,
) async {
  Map<String, dynamic> _jsonRoot = await _loadXliffAssetAsJson(baseFileName);
  HashMap<int, Item> items = HashMap();

  ensureList(_jsonRoot["xliff"]["file"]["body"]["trans-unit"]).forEach(
    (itemJson) {
      Item item = itemFromJson(itemJson);
      items[item.id] = item;
    },
  );

  _supportedLocales.forEach(
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

abstract class LocalizedItem {
  final int id = null;
  HashMap<String, String> localizedTexts = HashMap();

  String _unquote(String text) {
    return text.replaceAll("\\'", "'");
  }

  LocalizedItem(String text){
    if (text != null) {
      localizedTexts[K.defaultLocale.languageCode] = _unquote(text);
    }
  }

  String text([String locale]) {
    return localizedTexts[locale??K.defaultLocale.languageCode];
  }

  /// itemJson is a "trans-unit" from "<TYPE>/<LOCALE>.xliff"
  updateWithLocalizedJSON(Map<String, dynamic> itemJson, String locale) {
    localizedTexts[locale] = _unquote(itemJson["target"]["\$"]);
  }

  /// topicJSON is a "trans-unit" from "<TYPE>.xliff" or "<TYPE>/<LOCALE>.xliff"
  static int idFromJson(Map<String, dynamic> itemJson) {
    return int.parse(itemJson["@id"]);
  }
}
