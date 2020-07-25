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

  HashMap<Locale, UnmodifiableSetView<int>> _enabledQuestionIDs = HashMap();

  Topic({
    this.id,
    String baseText,
    this.color,
    this.icon,
    this.questions,
    this.sources = const [],
  }) : super(baseText);

  /// itemJson is a "trans-unit" from "<TYPE>/<LOCALE>.xliff"
  updateWithLocalizedXmlElement(XmlElement xmlItem, Locale locale) {
    super.updateWithLocalizedXmlElement(xmlItem, locale);
    _enabledQuestionIDs[locale] = UnmodifiableSetView(
      questions.values.where((question) => !question.isDisabled(locale)).map((question) => question.id).toSet(),
    );
  }

  bool isDisabled(Locale locale) {
    return super.isDisabled(locale) || _enabledQuestionIDs[locale].isEmpty;
  }

  UnmodifiableSetView<int> questionIDs(Locale locale) {
    return _enabledQuestionIDs[locale];
  }

  List<Question> shuffledQuestions(Locale locale) {
    return questions.values.toList()..shuffle();
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
    String baseText = xmlTopic.findElements("source").first.text;
    int id = LocalizedItem.idFromXmlElement(xmlTopic);

    Function copyQuestion = (int questionID) {
      assert(
        allQuestions.containsKey(questionID),
        "Question with ID '$questionID' in topic $id ($baseText) does not exist.",
      );
      topicQuestions[questionID] = allQuestions[questionID];
    };

    xmlTopic.findElements("question-ids").forEach((XmlElement xmlQuestionIDs) {
      xmlQuestionIDs.descendants.forEach((XmlNode xmlQuestionIDsItem) {
        if (xmlQuestionIDsItem is XmlElement) {
          if (xmlQuestionIDsItem.name.local == "list") {
            _idRegExp.allMatches(xmlQuestionIDsItem.text).forEach((match) => copyQuestion(int.parse(match.group(0))));
          } else if (xmlQuestionIDsItem.name.local == "range") {
            _range(xmlQuestionIDsItem).forEach((questionID) => copyQuestion(questionID));
          }
        }
      });
    });

    return Topic(
      id: id,
      baseText: baseText,
      color: colorByName(xmlTopic.getAttribute("color") ?? ""),
      icon: iconByName(xmlTopic.getAttribute("icon") ?? ""),
      questions: UnmodifiableMapView(topicQuestions),
      sources: sources,
    );
  }
}
