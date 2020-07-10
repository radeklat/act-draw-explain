import 'dart:collection';
import 'dart:convert';

import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/models/translation_file.dart';
import 'package:act_draw_explain/utilities/color.dart';
import 'package:act_draw_explain/utilities/icons.dart';
import 'package:act_draw_explain/utilities/iter.dart';
import 'package:flutter/services.dart';
import 'package:xml2json/xml2json.dart';

class GameData {
  static Map<int, Topic> topics = {};

  static initialize() async {
    topics = await loadTranslationFile<Topic>("topics", Topic.fromJson, Topic.idFromJson);
    topics.addAll(legacyTopics);
  }

  static List<int> get topicIDs {
    return topics.keys.toList();
  }
}
