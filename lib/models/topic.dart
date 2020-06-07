import 'dart:collection';

import 'package:flutter/material.dart';

class Topic {
  final int id;
  final String name;
  final Color color;
  final Icon icon;
  final UnmodifiableListView<int> questionIDs;
  final List<String> sources;

  const Topic({
    this.id,
    this.name,
    this.color,
    this.icon,
    this.questionIDs,
    this.sources = const [],
  });

  List<int> asShuffledQuestionIDs() {
    List<int> questionsCopy = List.from(questionIDs);
    questionsCopy.shuffle();
    return questionsCopy;
  }
}
