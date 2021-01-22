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
  final Map<int, List<int>> packages;

  static RegExp _idRegExp = RegExp(r"[0-9]+");

  HashMap<Locale, UnmodifiableSetView<int>> _enabledQuestionIDs = HashMap();

  Topic({
    this.id,
    String baseText,
    this.color,
    this.icon,
    this.questions,
    this.packages,
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
    HashMap<int, List<int>> packages = HashMap();
    String baseText = xmlTopic.findElements("source").first.text;
    int id = LocalizedItem.idFromXmlElement(xmlTopic);

    Function copyQuestion = (int questionID, List<int> packageQuestionIDs) {
      assert(
        allQuestions.containsKey(questionID),
        "Question with ID '$questionID' in topic $id ($baseText) does not exist.",
      );
      topicQuestions[questionID] = allQuestions[questionID];
      packageQuestionIDs.add(questionID);
    };

    xmlTopic.findElements("package-ids").forEach((XmlElement xmlPackage) {
      int level = int.parse(xmlPackage.getAttribute("level"));
      List<int> packageQuestionIDs = List();
      xmlPackage.descendants.forEach((XmlNode xmlQuestionIDsItem) {
        if (xmlQuestionIDsItem is XmlElement) {
          if (xmlQuestionIDsItem.name.local == "list") {
            _idRegExp
                .allMatches(xmlQuestionIDsItem.text)
                .forEach((match) => copyQuestion(int.parse(match.group(0)), packageQuestionIDs));
          } else if (xmlQuestionIDsItem.name.local == "range") {
            _range(xmlQuestionIDsItem).forEach((questionID) => copyQuestion(questionID, packageQuestionIDs));
          }
        }
      });
      packages[level] = packageQuestionIDs;
    });

    return Topic(
      id: id,
      baseText: baseText,
      color: colorByName(xmlTopic.getAttribute("color") ?? ""),
      icon: iconByName(xmlTopic.getAttribute("icon") ?? ""),
      questions: UnmodifiableMapView(topicQuestions),
      packages: packages,
      sources: sources,
    );
  }
}
