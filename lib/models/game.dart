import 'dart:collection';
import 'dart:ui';

import 'package:act_draw_explain/models/question.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/models/localized_item.dart';
import 'package:act_draw_explain/utilities/intl/localized_assets.dart';
import 'package:act_draw_explain/utilities/logging.dart';
import 'package:xml/xml.dart';

class GameData {
  static HashMap<int, Topic> topics = HashMap();
  static HashMap<int, Question> questions = HashMap();
  static Logger _log = Logger("GameData");

  static Future<bool> initialize(List<Locale> supportedLocales, [AssetLoader assetLoader]) async {
    List<String> supportedLanguageCodes = supportedLocales.map((locale) => locale.languageCode).toList();
    TranslationsLoader translationsLoader = TranslationsLoader(supportedLanguageCodes, assetLoader ?? AssetLoader());

    DateTime start = DateTime.now();

    questions = await translationsLoader.load<Question>(
      "questions",
      Question.fromXmlElement,
      LocalizedItem.idFromXmlElement,
    );
    topics = await translationsLoader.load<Topic>(
      "topics",
      (XmlElement topicXml) => Topic.fromXmlElement(questions, topicXml),
      LocalizedItem.idFromXmlElement,
    );

    _log.time(start).debug("Loaded");

    return true;
  }

  static Iterable<Topic> enabledTopics(String languageCode) {
    return topics.values.where((Topic topic) => !topic.isDisabled(languageCode));
  }

  static List<int> get topicIDs {
    return topics.keys.toList();
  }
}
