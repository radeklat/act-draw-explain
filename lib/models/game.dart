import 'dart:collection';

import 'package:act_draw_explain/models/question.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/models/translation_file.dart';

class GameData {
  static HashMap<int, Topic> topics = HashMap();
  static HashMap<int, Question> questions = HashMap();

  static initialize([AssetLoader assetLoader]) async {
    TranslationsLoader translationsLoader = TranslationsLoader(assetLoader??AssetLoader());

    topics = await translationsLoader.load<Topic>("topics", Topic.fromJson, LocalizedItem.idFromJson);
    questions = await translationsLoader.load<Question>("questions", Question.fromJson, LocalizedItem.idFromJson);
  }

  static List<int> get topicIDs {
    return topics.keys.toList();
  }
}
