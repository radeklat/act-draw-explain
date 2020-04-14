import 'dart:collection';

import 'package:act_draw_explain/models/topic.dart';
import 'package:flutter/material.dart';

UnmodifiableMapView<int, Topic> topics = UnmodifiableMapView(
  Map.fromIterable(
    [
      Topic(
        id: 2,
        name: "Brno",
        color: Colors.red.shade600,
        icon: Icon(Icons.location_city),
        questionIDs: UnmodifiableListView([for(var i=21; i<=49; i+=1) i]),
      ),
      Topic(
        id: 1,
        name: "Pohádky",
        color: Colors.lightBlueAccent,
        icon: Icon(Icons.ac_unit),
        questionIDs: UnmodifiableListView([for(var i=1; i<=20; i+=1) i]),
      ),
      Topic(
        id: 3,
        name: "Zahraniční seriály",
        color: Colors.deepPurple,
        icon: Icon(Icons.tv),
        questionIDs: UnmodifiableListView([for(var i=50; i<=64; i+=1) i]),
      ),
      Topic(
        id: 4,
        name: "IMDb Top 20 Movies",
        color: Colors.amber,
        icon: Icon(Icons.tv),
        questionIDs: UnmodifiableListView([for(var i=65; i<=84; i+=1) i]),
      ),
      Topic(
        id: 5,
        name: "ČSFD Top 20 Filmů",
        color: Colors.red.shade400,
        icon: Icon(Icons.tv),
        questionIDs: UnmodifiableListView([for(var i=85; i<=104; i+=1) i]),
      ),
      Topic(
        id: 6,
        name: "ČSFD Top 20 Seriálů",
        color: Colors.red.shade400,
        icon: Icon(Icons.tv),
        questionIDs: UnmodifiableListView([for(var i=105; i<=124; i+=1) i]),
      ),
      Topic(
        id: 7,
        name: "RuPaul's Drag Race",
        color: Colors.pinkAccent,
        icon: Icon(Icons.tv),
        questionIDs: UnmodifiableListView([for(var i=124; i<=169; i+=1) i]),
      ),
    ],
    key: (topic) => topic.id,
    value: (topic) => topic,
  ),
);
