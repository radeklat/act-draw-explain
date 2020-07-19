import 'dart:collection';

import 'package:act_draw_explain/constants.dart';
import 'package:act_draw_explain/models/localized_item.dart';
import 'package:act_draw_explain/models/question.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

_localize(LocalizedItem item, Map<String, String> localisations) {
  (localisations ?? {K.settings.locales.defaultValue: null}).forEach((languageCode, text) {
    item.updateWithLocalizedXmlElement(
      XmlElement(XmlName("trans-unit"), [], [
        XmlElement(XmlName("target"), [], [XmlText(text ?? "Fake $languageCode question")])
      ]),
      languageCode,
    );
  });
}

Question fakeQuestion(int id, {String baseText, Map<String, String> localisations}) {
  var question = Question(id: id, baseText: baseText ?? "Fake question");
  _localize(question, localisations);
  return question;
}

Topic fakeTopic({int id, String baseText, Map<String, String> localisations, HashMap<int, Question> questions}) {
  Topic topic = Topic(
    id: id ?? 1,
    baseText: baseText ?? "Fake topic",
    color: Colors.black,
    icon: Icon(Icons.score),
    questions: UnmodifiableMapView(questions ?? {}),
  );

  _localize(topic, localisations);

  return topic;
}
