import 'dart:collection';

import 'package:flutter/material.dart';

class Topic {
  static const _DEFAULT_LOCALE = 'cs';  // TODO: Remove when migration is finished

  final int id;
  final Color color;
  final Icon icon;
  final UnmodifiableListView<int> questionIDs;
  final List<String> sources;
  final bool migrated;
  HashMap<String, String> localizedNames = HashMap();

  Topic({
    this.id,
    name, // TODO: Remove when migration is finished
    this.color,
    this.icon,
    this.questionIDs,
    this.sources = const [],
    this.migrated = false,
  }) {
    if (name != null) {
      localizedNames[_DEFAULT_LOCALE] = name;
    }
  }

  String name([String locale = _DEFAULT_LOCALE]) {
    return localizedNames[locale];
  }

  String setName(String name, String locale) {
    return localizedNames[locale] = name;
  }

  List<int> asShuffledQuestionIDs() {
    List<int> questionsCopy = List.from(questionIDs);
    questionsCopy.shuffle();
    return questionsCopy;
  }
}
