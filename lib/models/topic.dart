import 'dart:collection';

import 'package:act_draw_explain/models/question.dart';
import 'package:act_draw_explain/models/localized_item.dart';
import 'package:act_draw_explain/utilities/color.dart';
import 'package:act_draw_explain/utilities/icons.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

class Topic extends LocalizedItem {
  final int id;
  final Color color;
  final Icon icon;
  final UnmodifiableMapView<int, Question> questions;
  final List<String> sources;

  static RegExp _idRegExp = RegExp(r"[0-9]+");

  HashMap<String, UnmodifiableSetView<int>> _enabledQuestionIDs = HashMap();

  Topic({
    this.id,
    String baseText,
    this.color,
    this.icon,
    this.questions,
    this.sources = const [],
  }) : super(baseText);

  /// itemJson is a "trans-unit" from "<TYPE>/<LOCALE>.xliff"
  updateWithLocalizedXmlElement(XmlElement xmlItem, String languageCode) {
    super.updateWithLocalizedXmlElement(xmlItem, languageCode);
    _enabledQuestionIDs[languageCode] = UnmodifiableSetView(
      questions.values.where((question) => !question.isDisabled(languageCode)).map((question) => question.id).toSet(),
    );
  }

  bool isDisabled(String languageCode) {
    return super.isDisabled(languageCode) || _enabledQuestionIDs[languageCode].isEmpty;
  }

  UnmodifiableSetView<int> questionIDs(String languageCode) {
    return _enabledQuestionIDs[languageCode];
  }

  List<int> asShuffledQuestionIDs(String languageCode) {
    List<int> questionsCopy = List.from(questionIDs(languageCode));
    questionsCopy.shuffle();
    return questionsCopy;
  }

  static List<int> _range(XmlElement xmlRange) {
    int min = int.parse(xmlRange.getAttribute("min"));
    int max = int.parse(xmlRange.getAttribute("max"));
    return [for (var i = min; i <= max; i += 1) i];
  }

  /// topicJSON is a "trans-unit" from "topics.xliff"
  static Topic fromXmlElement(HashMap<int, Question> allQuestions, XmlElement xmlTopic) {
    List<String> sources = xmlTopic
        .findElements("attribution")
        .map(
          (XmlElement attribution) => attribution.getAttribute("url"),
        )
        .toList();

    HashMap<int, Question> topicQuestions = HashMap();

    xmlTopic.findElements("question-ids").forEach((XmlElement xmlQuestionIDs) {
      xmlQuestionIDs.descendants.forEach((XmlNode xmlQuestionIDsItem) {
        if (xmlQuestionIDsItem is XmlElement) {
          if (xmlQuestionIDsItem.name.local == "list") {
            _idRegExp.allMatches(xmlQuestionIDsItem.text).forEach((match) {
              int questionID = int.parse(match.group(0));
              topicQuestions[questionID] = allQuestions[questionID];
            });
          } else if (xmlQuestionIDsItem.name.local == "range") {
            _range(xmlQuestionIDsItem).forEach((questionID) {
              topicQuestions[questionID] = allQuestions[questionID];
            });
          }
        }
      });
    });

    return Topic(
      id: LocalizedItem.idFromXmlElement(xmlTopic),
      baseText: xmlTopic.findElements("source").first.text,
      color: colorByName(xmlTopic.getAttribute("color") ?? ""),
      icon: iconByName(xmlTopic.getAttribute("icon") ?? ""),
      questions: UnmodifiableMapView(topicQuestions),
      sources: sources,
    );
  }
}
