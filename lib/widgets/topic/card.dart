import 'package:act_draw_explain/models/results.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/screens/game/start_game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilities/color.dart';
import 'counter.dart';
import 'name_icon.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  const TopicCard({Key key, @required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector(
      selector: (context, TopicBestScore topicBestResults) => topicBestResults.get(topicID: topic.id),
      builder: (context, bestScore, child) {
        Color backgroundColor = topic.color;
        Color foregroundColor = contrastingTextColor(backgroundColor);

        return FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          color: backgroundColor,
          onPressed: () {
            Navigator.pushNamed(context, StartGameScreen.ID, arguments: topic.id);
          },
          child: Stack(
            children: <Widget>[
              TopicNameIcon(foregroundColor: foregroundColor, topic: topic),
              TopicCounter(
                alignment: Alignment.topRight,
                valueTop: "${bestScore ?? 0}",
                valueBottom: "${topic.questionIDs.length}",
                foregroundColor: foregroundColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
