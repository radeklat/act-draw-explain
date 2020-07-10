import 'dart:collection';

import 'package:act_draw_explain/utilities/color.dart';
import 'package:act_draw_explain/utilities/icons.dart';
import 'package:act_draw_explain/utilities/iter.dart';
import 'package:flutter/material.dart';

class Topic {
  static const _DEFAULT_LOCALE = 'cs'; // TODO: Remove when migration is finished

  final int id;
  final Color color;
  final Icon icon;
  final UnmodifiableListView<int> questionIDs;
  final List<String> sources;
  HashMap<String, String> localizedNames = HashMap();

  Topic({
    this.id,
    name, // TODO: Remove when migration is finished
    this.color,
    this.icon,
    this.questionIDs,
    this.sources = const [],
  }) {
    if (name != null) {
      localizedNames[_DEFAULT_LOCALE] = name;
    }
  }

  String name([String locale = _DEFAULT_LOCALE]) {
    return localizedNames[locale];
  }

  /// topicJSON is a "trans-unit" from "topics/<LOCALE>.xliff"
  updateWithLocalizedJSON(Map<String, dynamic> topicJson, String locale) {
    localizedNames[locale] = topicJson["target"]["\$"];
  }

  List<int> asShuffledQuestionIDs() {
    List<int> questionsCopy = List.from(questionIDs);
    questionsCopy.shuffle();
    return questionsCopy;
  }

  static List<int> _range(Map<String, dynamic> range) {
    int min = int.parse(range["@min"]);
    int max = int.parse(range["@max"]);
    return [for (var i = min; i <= max; i += 1) i];
  }

  /// topicJSON is a "trans-unit" from "topics.xliff" or "topics/<LOCALE>.xliff"
  static int idFromJson(Map<String, dynamic> topicJson) {
    return int.parse(topicJson["@id"]);
  }

  /// topicJSON is a "trans-unit" from "topics.xliff"
  static Topic fromJson(Map<String, dynamic> topicJson) {
    List<String> sources = ensureList(topicJson["attribution"])
        .map(
          (attribution) => attribution["@url"].toString(),
        )
        .toList();

    List<int> questionIDs = [];
    topicJson["question-ids"].forEach((String key, dynamic value) {
      if (key == "list") {
        ensureList(value).forEach(
          (list) => list["\$"].split(",").forEach(
                (questionID) => questionIDs.add(int.parse(questionID)),
              ),
        );
      } else if (key == "range") {
        ensureList(value).forEach(
          (range) => questionIDs.addAll(_range(range)),
        );
      }
    });

    return Topic(
      id: idFromJson(topicJson),
      name: topicJson["source"]["\$"],
      color: colorByName(topicJson["@color"]),
      icon: iconByName(topicJson["@icon"]),
      questionIDs: UnmodifiableListView(questionIDs),
      sources: sources,
    );
  }
}
