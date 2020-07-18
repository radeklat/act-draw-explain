import 'dart:collection';
import 'dart:ui';

import 'package:act_draw_explain/models/question.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/models/translation_file.dart';

class GameData {
  static HashMap<int, Topic> topics = HashMap();
  static HashMap<int, Question> questions = HashMap();

  static Future<bool> initialize(List<Locale> supportedLocales, [AssetLoader assetLoader]) async {
    List<String> supportedLanguageCodes = supportedLocales.map((locale) => locale.languageCode).toList();
    TranslationsLoader translationsLoader = TranslationsLoader(supportedLanguageCodes, assetLoader ?? AssetLoader());

    questions = await translationsLoader.load<Question>("questions", Question.fromJson, LocalizedItem.idFromJson);
    topics = await translationsLoader.load<Topic>("topics", Topic.fromJson, LocalizedItem.idFromJson);

    return true;
  }

  static Iterable<Topic> enabledTopics(String languageCode) {
    return topics.values.where((Topic topic) => !topic.isDisabled(languageCode));
  }

  static List<int> get topicIDs {
    return topics.keys.toList();
  }
}
