import 'dart:collection';
import 'dart:convert';

import 'package:act_draw_explain/utilities/iter.dart';
import 'package:act_draw_explain/utilities/logging.dart';
import 'package:flutter/services.dart';
import 'package:xml2json/xml2json.dart';


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
  final _log = Logger("TranslationsLoader");
  final _xmlToJson = Xml2Json();

  TranslationsLoader(this.supportedLanguageCodes, this.assetFileLoader);

  /// Returns XLIFF document as JSON in Badgerfish Convention
  /// See: http://wiki.open311.org/JSON_and_XML_Conversion/
  Future<Map<String, dynamic>> _loadXliffAssetAsJson(String type, [String locale]) async {
    String xmlContent = await assetFileLoader.loadString(type, locale);
    _log.debug("XML loaded");

    _xmlToJson.parse(xmlContent);
    _log.debug("XML parsed");
    var jsonString = _xmlToJson.toBadgerfish();
    _log.debug("XML converted to JSON");
    var decodedJson = jsonDecode(jsonString);
    _log.debug("JSON decoded");
    return decodedJson;
  }

  Future<HashMap<int, Item>> load<Item extends LocalizedItem>(
    String itemType,
    Function itemFromJson,
    Function idFromJson,
  ) async {
    _log.debug("Loading file with $itemType");
    Map<String, dynamic> _jsonRoot = await _loadXliffAssetAsJson(itemType);
    _log.debug("Processing $itemType");
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

    for (String languageCode in supportedLanguageCodes) {
      _log.debug("Loading file with $itemType/$languageCode");
      Map<String, dynamic> localizedItemJson = await _loadXliffAssetAsJson(itemType, languageCode);
      _log.debug("Processing $itemType/$languageCode");
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
      _log.debug("File with $itemType/$languageCode loaded");
    }

    _log.debug("File with $itemType loaded");
    return items;
  }
}

abstract class LocalizedItem {
  static const DISABLED = "DISABLED";
  final int id = null;
  final String baseText;
  final _log = Logger("LocalizedItem");
  HashMap<String, String> localizedTexts = HashMap();

  LocalizedItem(this.baseText);

  String _unquote(String text) {
    return text.replaceAll("\\'", "'");
  }

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
