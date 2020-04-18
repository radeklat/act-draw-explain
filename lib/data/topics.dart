import 'dart:collection';

import 'package:act_draw_explain/models/topic.dart';
import 'package:flutter/material.dart';

UnmodifiableListView<int> range(int min, int max, {List<int> extra}) {
  return UnmodifiableListView([for(var i=min; i<=max; i+=1) i, ...(extra ?? [])]);
}

UnmodifiableMapView<int, Topic> topics = UnmodifiableMapView(
  Map.fromIterable(
    [
      Topic(
        id: 2,
        name: "Brno",
        color: Colors.red.shade600,
        icon: Icon(Icons.location_city),
        questionIDs: range(21, 49, extra: [264, 265]),
      ),
      Topic(
        id: 1,
        name: "Pohádky",
        color: Colors.lightBlueAccent,
        icon: Icon(Icons.ac_unit),
        questionIDs: range(1, 20, extra: range(355, 384)),
      ),
      Topic(
        id: 3,
        name: "Zahraniční seriály",
        color: Colors.deepPurple,
        icon: Icon(Icons.tv),
        questionIDs: range(50, 64),
      ),
      Topic(
        id: 4,
        name: "IMDb Top 20 Movies",
        color: Colors.amber,
        icon: Icon(Icons.tv),
        questionIDs: range(65, 84),
      ),
      Topic(
        id: 5,
        name: "ČSFD Top 20 Filmů",
        color: Colors.red.shade400,
        icon: Icon(Icons.tv),
        questionIDs: range(85, 104),
      ),
      Topic(
        id: 6,
        name: "ČSFD Top 20 Seriálů",
        color: Colors.red.shade400,
        icon: Icon(Icons.tv),
        questionIDs: range(105, 124),
      ),
      Topic(
        id: 7,
        name: "RuPaul's Drag Race",
        color: Colors.pinkAccent,
        icon: Icon(Icons.tv),
        questionIDs: range(125, 172),
      ),
      Topic(
        id: 8,
        name: "Top Android Apps",
        color: Colors.green,
        icon: Icon(Icons.android),
        questionIDs: range(173, 201),
      ),
      Topic(
        id: 9,
        name: "Praha",
        color: Colors.amberAccent,
        icon: Icon(Icons.location_city),
        questionIDs: range(202, 240),
      ),
      Topic(
        id: 10,
        name: "České památky",
        color: Colors.blue,
        icon: Icon(Icons.visibility),
        questionIDs: range(241, 263, extra: [41, 46, 203, 204, 207, 221]),
      ),
      Topic(
        id: 11,
        name: "Čeští interpreti",
        color: Colors.purpleAccent,
        icon: Icon(Icons.music_note),
        questionIDs: range(266, 302),
      ),
      Topic(
        id: 12,
        name: "Čeští herci a herečky",
        color: Colors.lime,
        icon: Icon(Icons.tv),
        questionIDs: range(303, 342, extra: [292, 302]),
      ),
      Topic(
        id: 13,
        name: "Prezidenti ČR a ČS",
        color: Colors.yellow,
        icon: Icon(Icons.person),
        questionIDs: range(343, 354),
      ),
      Topic(
        id: 14,
        name: "Státy Evropy",
        color: Colors.blueAccent,
        icon: Icon(Icons.language),
        questionIDs: range(385, 434),
      ),
    ],
    key: (topic) => topic.id,
    value: (topic) => topic,
  ),
);
