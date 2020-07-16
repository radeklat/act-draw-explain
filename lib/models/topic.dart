import 'dart:collection';

import 'package:act_draw_explain/models/game.dart';
import 'package:act_draw_explain/models/question.dart';
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
  final UnmodifiableMapView<int, Question> questions;
  final List<String> sources;

  static RegExp _idRegExp = RegExp(r"[0-9]+");

  Topic({
    this.id,
    String baseText,
    this.color,
    this.icon,
    this.questions,
    this.sources = const [],
  }) : super(baseText);

  UnmodifiableSetView<int> questionIDs(String languageCode) {
    return UnmodifiableSetView(
      questions.values.where((question) => !question.isDisabled(languageCode)).map((question) => question.id).toSet(),
    );
  }

  List<int> asShuffledQuestionIDs(String languageCode) {
    List<int> questionsCopy = List.from(questionIDs(languageCode));
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

    HashMap<int, Question> questions = HashMap();

    topicJson["question-ids"].forEach((String key, dynamic value) {
      if (key == "list") {
        ensureList(value).forEach(
          (list) => _idRegExp.allMatches(list["\$"]).forEach(
            (match) {
              int questionID = int.parse(match.group(0));
              questions[questionID] = GameData.questions[questionID];
            },
          ),
        );
      } else if (key == "range") {
        ensureList(value).forEach(
          (range) => _range(range).forEach((questionID) {
            questions[questionID] = GameData.questions[questionID];
          }),
        );
      }
    });

    return Topic(
      id: LocalizedItem.idFromJson(topicJson),
      baseText: topicJson["source"]["\$"],
      color: colorByName(topicJson["@color"] ?? ""),
      icon: iconByName(topicJson["@icon"] ?? ""),
      questions: UnmodifiableMapView(questions),
      sources: sources,
    );
  }
}
