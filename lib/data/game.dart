import 'dart:collection';

import 'package:act_draw_explain/models/game.dart';

Game game = Game(
  topicIDs: UnmodifiableListView(List.generate(30, (_index) => 1)),
);
