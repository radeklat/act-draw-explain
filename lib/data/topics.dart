import 'dart:collection';

import 'package:act_draw_explain/models/topic.dart';
import 'package:flutter/material.dart';

UnmodifiableMapView<int, Topic> topics = UnmodifiableMapView(
  Map.fromIterable(
    [
      Topic(
        id: 1,
        name: "Pohádky",
        color: Colors.lightBlueAccent,
        icon: Icon(Icons.ac_unit),
        questionIDs: UnmodifiableListView([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]),
      ),
    ],
    key: (topic) => topic.id,
    value: (topic) => topic,
  ),
);
