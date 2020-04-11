import 'package:flutter/material.dart';


class Topic {
  final int id;
  final String name;
  final Color color;
  final Icon icon;
  final List<int> questionIDs;

  const Topic({this.id, this.name, this.color, this.icon, this.questionIDs});

  List<int> asShuffledQuestionIDs() {
    List<int> questionsCopy = List.from(questionIDs);
    questionsCopy.shuffle();
    return questionsCopy;
  }
}
