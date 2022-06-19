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

  HashMap<Locale, UnmodifiableSetView<int>> _displayableQuestionIDs = HashMap();
  Set<int> _enabledPackageIDs = Set();
  Set<int> _questionIDsInDisabledPackages = Set();

  Topic({
    required this.id,
    required String baseText,
    required this.color,
    required this.icon,
    required this.questions,
    required this.packages,
    this.sources = const [],
  }) : super(baseText) {
    setEnabledPackages({1});  // TODO: Requires ability to buy packages.
  }

  void setEnabledPackages(Set<int> packageIDs) {
    _enabledPackageIDs = packageIDs;

    // Remember all question IDs that are present in disabled packages to hide them
    packages.forEach((packageID, packageQuestionIDs) {
      if (!_enabledPackageIDs.contains(packageID)) {
        _questionIDsInDisabledPackages.addAll(packageQuestionIDs);
      }
    });
  }

  /// itemJson is a "trans-unit" from "<TYPE>/<LOCALE>.xliff"
  updateWithLocalizedXmlElement(XmlElement xmlItem, Locale locale) {
    super.updateWithLocalizedXmlElement(xmlItem, locale);
    _displayableQuestionIDs[locale] = UnmodifiableSetView(
      questions.values.where((question) => !question.isDisabled(locale)).map((question) => question.id).toSet(),
    );
  }

  bool isDisabled(Locale locale) {
    return super.isDisabled(locale) || _displayableQuestionIDs[locale]!.isEmpty;
  }

  int length(Locale locale) {
    return _enabledQuestionIDs(locale).length;
  }

  List<Question> shuffledQuestions(Locale locale) {
    return _enabledQuestionIDs(locale).map((questionId) => questions[questionId]!).toList()..shuffle();
  }

  Set<int> _enabledQuestionIDs(Locale locale) {
    return _displayableQuestionIDs[locale]!.difference(_questionIDsInDisabledPackages);
  }

  static List<int> _range(XmlElement xmlRange) {
    int min = int.parse(xmlRange.getAttribute("min")!);
    int max = int.parse(xmlRange.getAttribute("max")!);
    return [for (var i = min; i <= max; i += 1) i];
  }

  /// topicJSON is a "trans-unit" from "topics.xliff"
  static Topic fromXmlElement(HashMap<int, Question> allQuestions, XmlElement xmlTopic) {
    List<String> sources = xmlTopic
        .findElements("attribution")
        .map(
          (XmlElement attribution) => attribution.getAttribute("url")!,
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
      topicQuestions[questionID] = allQuestions[questionID]!;
      packageQuestionIDs.add(questionID);
    };

    xmlTopic.findElements("package-ids").forEach((XmlElement xmlPackage) {
      int level = int.parse(xmlPackage.getAttribute("level")!);
      List<int> packageQuestionIDs = List.empty();
      xmlPackage.descendants.forEach((XmlNode xmlQuestionIDsItem) {
        if (xmlQuestionIDsItem is XmlElement) {
          if (xmlQuestionIDsItem.name.local == "list") {
            _idRegExp
                .allMatches(xmlQuestionIDsItem.text)
                .forEach((match) => copyQuestion(int.parse(match.group(0)!), packageQuestionIDs));
          } else if (xmlQuestionIDsItem.name.local == "range") {
            _range(xmlQuestionIDsItem).forEach((questionID) => copyQuestion(questionID, packageQuestionIDs));
          }
        }
      });
      assert(!packages.containsKey(level), "Topic with ID $id ($baseText) contains level '$level' more than once.");
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
