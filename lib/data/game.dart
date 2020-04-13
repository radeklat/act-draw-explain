import 'dart:collection';

import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/models/game.dart';

Game game = Game(
  topicIDs: UnmodifiableListView(topics.keys),
);
