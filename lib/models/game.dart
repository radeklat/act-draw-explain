import 'dart:collection';

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

  static Future initialize([AssetLoader assetLoader]) async {
    if (!_initialized) {
      TranslationsLoader translationsLoader = TranslationsLoader(assetLoader ?? AssetLoader());

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
