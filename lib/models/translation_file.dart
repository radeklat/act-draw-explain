import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:act_draw_explain/utilities/iter.dart';
import 'package:flutter/services.dart';
import 'package:xml2json/xml2json.dart';

import '../constants.dart';

class AssetLoader {
  static const String ASSETS_DIR = "assets/data";

  Future<String> loadString(String type, [String locale]) async {
    return await rootBundle.loadString(languageFile(type, locale));
  }

  String languageFile(String type, [String locale]) {
    locale = (locale == null) ? "" : "/$locale";
    return '$ASSETS_DIR/$type$locale.xliff';
  }
}

class TranslationsLoader {
  final AssetLoader assetFileLoader;
  final List<String> supportedLanguageCodes;

  TranslationsLoader(this.supportedLanguageCodes, this.assetFileLoader);

  /// Returns XLIFF document as JSON in Badgerfish Convention
  /// See: http://wiki.open311.org/JSON_and_XML_Conversion/
  Future<Map<String, dynamic>> _loadXliffAssetAsJson(String type, [String locale]) async {
    String xmlContent = await assetFileLoader.loadString(type, locale);
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

    supportedLanguageCodes.forEach(
      (String languageCode) async {
        Map<String, dynamic> localizedItemJson = await _loadXliffAssetAsJson(itemType, languageCode);
        Set<String> seenFileOriginals = {};

        ensureList(localizedItemJson["xliff"]["file"]).forEach((jsonFile) {
          String transItemLanguageCode = jsonFile["@target-language"];
          assert(
            transItemLanguageCode == languageCode,
            "<trans-item target-language='$transItemLanguageCode'> does not match "
            "the $itemType/$languageCode file language code '$languageCode'",
          );

          String original = jsonFile["@original"];
          assert(
            !seenFileOriginals.contains(original),
            "<file original='$original'> appear in the $itemType/$languageCode file more than once",
          );
          seenFileOriginals.add(original);

          ensureList(jsonFile["body"]["trans-unit"]).forEach(
            (itemJson) {
              items[idFromJson(itemJson)].updateWithLocalizedJSON(itemJson, languageCode);
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
  final String baseText;
  HashMap<String, String> localizedTexts = HashMap();

  LocalizedItem(this.baseText);

  String _unquote(String text) {
    return text.replaceAll("\\'", "'");
  }

  String text(String languageCode) {
    if (!localizedTexts.containsKey(languageCode)) {
      stderr.write("'$languageCode' translation for '$baseText' is not available");
    }
    return localizedTexts[languageCode];
  }

  bool isDisabled(String languageCode) {
    String itemText = text(languageCode);
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

  @override
  String toString() {
    return "$id: $baseText";
  }
}
