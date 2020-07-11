import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/models/translation_file.dart';

class GameData {
  static Map<int, Topic> topics = {};

  static initialize() async {
    topics = await loadTranslationFile<Topic>("topics", Topic.fromJson, LocalizedItem.idFromJson);
    topics.addAll(legacyTopics);
  }

  static List<int> get topicIDs {
    return topics.keys.toList();
  }
}
