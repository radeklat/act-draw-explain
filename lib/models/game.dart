import 'dart:collection';
import 'dart:ui';

import 'package:act_draw_explain/models/question.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/models/translation_file.dart';

class GameData {
  static HashMap<int, Topic> topics = HashMap();
  static HashMap<int, Question> questions = HashMap();
  static bool _initialized = false;

  bool get initialized {
    return _initialized;
  }

  static Future initialize(List<Locale> supportedLocales, [AssetLoader assetLoader]) async {
    if (!_initialized) {
      List<String> supportedLanguageCodes = supportedLocales.map((locale) => locale.languageCode).toList();
      TranslationsLoader translationsLoader = TranslationsLoader(supportedLanguageCodes, assetLoader ?? AssetLoader());

      questions = await translationsLoader.load<Question>("questions", Question.fromJson, LocalizedItem.idFromJson);
      topics = await translationsLoader.load<Topic>("topics", Topic.fromJson, LocalizedItem.idFromJson);
      _initialized = true;
    }
  }

  static Iterable<Topic> enabledTopics(String languageCode) {
    return topics.values.where((Topic topic) => !topic.isDisabled(languageCode));
  }

  static List<int> get topicIDs {
    return topics.keys.toList();
  }
}
