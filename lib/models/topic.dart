import 'dart:collection';

import 'package:act_draw_explain/models/translation_file.dart';
import 'package:act_draw_explain/utilities/color.dart';
import 'package:act_draw_explain/utilities/icons.dart';
import 'package:act_draw_explain/utilities/iter.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class Topic extends LocalizedItem {
  final int id;
  final Color color;
  final Icon icon;
  final UnmodifiableSetView<int> questionIDs;
  final List<String> sources;

  Topic({
    this.id,
    String text, // TODO: Remove when migration is finished
    this.color,
    this.icon,
    this.questionIDs,
    this.sources = const [],
  }) : super(text);

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

  /// topicJSON is a "trans-unit" from "topics.xliff"
  static Topic fromJson(Map<String, dynamic> topicJson) {
    List<String> sources = ensureList(topicJson["attribution"])
        .map(
          (attribution) => attribution["@url"].toString(),
        )
        .toList();

    Set<int> questionIDs = {};
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
      id: LocalizedItem.idFromJson(topicJson),
      text: topicJson["source"]["\$"],
      color: colorByName(topicJson["@color"]??""),
      icon: iconByName(topicJson["@icon"]??""),
      questionIDs: UnmodifiableSetView(questionIDs),
      sources: sources,
    );
  }
}
