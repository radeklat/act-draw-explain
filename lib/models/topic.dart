import 'dart:collection';

import 'package:flutter/material.dart';


class Topic {
  final int id;
  final String name;
  final Color color;
  final Icon icon;
  final UnmodifiableListView<int> questionIDs;

  Topic({this.id, this.name, this.color, this.icon, this.questionIDs});

  List<int> get shuffledQuestions {
    List<int> questionsCopy = List.from(questionIDs);
    questionsCopy.shuffle();
    return questionsCopy;
  }
}
