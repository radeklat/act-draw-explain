import 'dart:collection';

import 'package:act_draw_explain/models/game.dart';

Game game = Game(
  topicIDs: UnmodifiableListView([for(var i=1; i<=3; i+=1) i]),
);
