import 'dart:collection';

import 'package:act_draw_explain/utilities/logging.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

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

  TranslationsLoader(this.supportedLanguageCodes, this.assetFileLoader);

  /// Returns XLIFF document as JSON in Badgerfish Convention
  /// See: http://wiki.open311.org/JSON_and_XML_Conversion/
  Future<XmlDocument> _loadXliffAsset(String type, [String locale]) async {
    DateTime start = DateTime.now();
    var log = _log.subLogger(type).subLogger(locale);
    String xmlContent = await assetFileLoader.loadString(type, locale);
    log.time(start).debug("File content loaded");

    start = DateTime.now();
    XmlDocument parsedXml = parse(xmlContent);
    log.time(start).debug("XML parsed");

    return parsedXml;
  }

  Future<HashMap<int, Item>> load<Item extends LocalizedItem>(
    String itemType,
    Function(XmlElement) itemFromXmlElement,
    Function(XmlElement) idFromXmlElement,
  ) async {
    DateTime start = DateTime.now();
    XmlDocument xmlRoot = await _loadXliffAsset(itemType);
    var log = _log.subLogger(itemType);
    log.time(start).debug("String loaded");
    HashMap<int, Item> items = HashMap();

    xmlRoot.findAllElements("file").forEach((XmlElement xmlFile) {
      xmlFile.findAllElements("trans-unit").forEach(
        (XmlElement xmlItem) {
          Item item = itemFromXmlElement(xmlItem);
          assert(
            !items.containsKey(item.id),
            "$itemType with ID '${item.id}' appear in the source file more than once",
          );
          items[item.id] = item;
        },
      );
    });

    log.time(start).debug("File loaded");

    for (String languageCode in supportedLanguageCodes) {
      start = DateTime.now();
      XmlDocument xmlLocalizedItem = await _loadXliffAsset(itemType, languageCode);
      var langLog = log.subLogger(languageCode);
      langLog.time(start).debug("String loaded");

      Set<String> seenFileOriginals = {};

      xmlLocalizedItem.findAllElements("file").forEach((XmlElement xmlFile) {
        String transItemLanguageCode = xmlFile.getAttribute("target-language");
        langLog.when(transItemLanguageCode != languageCode).error(
              "<trans-item target-language='$transItemLanguageCode'> does not match "
              "the file language code",
            );

        String original = xmlFile.getAttribute("original");
        langLog.when(seenFileOriginals.contains(original)).error(
              "<file original='$original'> appear in the $itemType/$languageCode file more than once",
            );
        seenFileOriginals.add(original);

        xmlFile.findAllElements("trans-unit").forEach(
          (XmlElement xmlItem) {
            items[idFromXmlElement(xmlItem)].updateWithLocalizedXmlElement(xmlItem, languageCode);
          },
        );
      });
      langLog.time(start).debug("File loaded");
    }


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
