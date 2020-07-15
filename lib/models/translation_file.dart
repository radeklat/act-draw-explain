import 'dart:collection';
import 'dart:convert';

import 'package:act_draw_explain/utilities/iter.dart';
import 'package:flutter/services.dart';
import 'package:xml2json/xml2json.dart';

import '../constants.dart';

// TODO: Replace with `localizationsDelegate.supportedLocales`
UnmodifiableListView<String> _supportedLocales = UnmodifiableListView(["cs", "en"]);

class AssetLoader {
  Future<String> loadString(filename) async {
    return await rootBundle.loadString(filename);
  }
}

class TranslationsLoader {
  final AssetLoader assetFileLoader;

  TranslationsLoader(this.assetFileLoader);

  /// Returns XLIFF document as JSON in Badgerfish Convention
  /// See: http://wiki.open311.org/JSON_and_XML_Conversion/
  Future<Map<String, dynamic>> _loadXliffAssetAsJson(String type, [String locale]) async {
    locale = (locale == null) ? "" : "/$locale";
    String xmlContent = await assetFileLoader.loadString('assets/data/$type$locale.xliff');
    var xmlToJson = Xml2Json();
    xmlToJson.parse(xmlContent);
    return jsonDecode(xmlToJson.toBadgerfish());
  }

  Future<HashMap<int, Item>> load<Item extends LocalizedItem>(
    String itemType,
    Function itemFromJson,
    Function idFromJson,
  ) async {
    Map<String, dynamic> _jsonRoot = await _loadXliffAssetAsJson(itemType);
    HashMap<int, Item> items = HashMap();

    ensureList(_jsonRoot["xliff"]["file"]).forEach((fileJson) {
      ensureList(fileJson["body"]["trans-unit"]).forEach(
        (itemJson) {
          Item item = itemFromJson(itemJson);
          assert(
            !items.containsKey(item.id),
            "$itemType with ID '${item.id}' appear in the source file more than once",
          );
          items[item.id] = item;
        },
      );
    });

    _supportedLocales.forEach(
      (String locale) async {
        Map<String, dynamic> localizedItemJson = await _loadXliffAssetAsJson(itemType, locale);
        Set<String> seenFileOriginals = {};

        ensureList(localizedItemJson["xliff"]["file"]).forEach((jsonFile) {
          String original = jsonFile["@original"];
          assert(
            !seenFileOriginals.contains(original),
            "<file original='$original'> appear in the $itemType/$locale file more than once",
          );
          seenFileOriginals.add(original);

          ensureList(jsonFile["body"]["trans-unit"]).forEach(
            (itemJson) {
              items[idFromJson(itemJson)].updateWithLocalizedJSON(itemJson, jsonFile["@target-language"]);
            },
          );
        });
      },
    );

    return items;
  }
}

abstract class LocalizedItem {
  static const DISABLED = "DISABLED";
  final int id = null;
  HashMap<String, String> localizedTexts = HashMap();
  static List<String> _displayLanguages = [K.defaultLocale.languageCode];

  static set displayLanguages(List<String> displayLanguages) {
    assert (displayLanguages.length >= 1);
    _displayLanguages = displayLanguages;
  }

  static List<String> get displayLanguages {
    return _displayLanguages;
  }

  String _unquote(String text) {
    return text.replaceAll("\\'", "'");
  }

  String text([String locale]) {
    return localizedTexts[locale ?? _displayLanguages[0]];
  }

  bool isDisabled([String locale]) {
    String itemText = text(locale);
    // Explicitly disabled or missing translation
    return itemText == DISABLED || itemText == "";
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
