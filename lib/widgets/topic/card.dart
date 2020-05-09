import 'package:act_draw_explain/models/results.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/screens/game/start_game.dart';
import 'package:act_draw_explain/screens/topic_edit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilities/color.dart';
import 'counter.dart';
import 'name_icon.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  static const double UNPLAYED_LIGHTNESS = 0.2;

  const TopicCard({Key key, @required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector(
      selector: (context, TopicBestScore topicBestResults) => topicBestResults.get(topicID: topic.id),
      builder: (context, bestScore, child) {
        Color backgroundColor = topic.color; //(bestScore == null) ? lighten(topic.color, UNPLAYED_LIGHTNESS) : topic.color;
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

class AddTopicCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      color: Colors.grey.shade300,
      onPressed: () {
        Navigator.pushNamed(context, TopicEditScreen.ID);
      },
      child: Container(
        width: 200,
        height: 200,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.add, size: 50, color: Colors.black),
            SizedBox(height: 5),
            Container(
              constraints: BoxConstraints(maxHeight: 42),
              child: AutoSizeText(
                "Přidat téma",
                style: Theme.of(context).textTheme.button.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
                maxLines: 2,
                minFontSize: Theme.of(context).textTheme.overline.fontSize,
                overflow: TextOverflow.fade,
                wrapWords: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
