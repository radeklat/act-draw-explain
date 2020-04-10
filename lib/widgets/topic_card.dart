import 'package:act_draw_explain/models/results.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/screens/start_game.dart';
import 'package:flutter/material.dart';

import '../utilities.dart';

class TopicCard extends StatefulWidget {
  const TopicCard({
    Key key,
    @required this.topic,
  }) : super(key: key);

  final Topic topic;

  @override
  _TopicCardState createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
  static const double UNPLAYED_LIGHTNESS = 0.2;
  int bestScore;
  Color backgroundColor;
  Color foregroundColor;

  @override
  void initState() {
    backgroundColor = lighten(widget.topic.color, UNPLAYED_LIGHTNESS);
    foregroundColor = contrastingTextColor(backgroundColor);

    Results.getBestScore(topicID: widget.topic.id).then((score) {
      setState(() {
        bestScore = score;
        backgroundColor = (bestScore == null) ? lighten(widget.topic.color, UNPLAYED_LIGHTNESS) : widget.topic.color;
        foregroundColor = contrastingTextColor(backgroundColor);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: backgroundColor,
      onPressed: () {
        Navigator.pushNamed(context, StartGameScreen.ID, arguments: widget.topic.id);
      },
      child: Container(
        width: 200,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TODO: Change icon color
            widget.topic.icon,
            SizedBox(
              height: 10,
            ),
            Text(
              widget.topic.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: foregroundColor),
              textAlign: TextAlign.center,
            ),
            Text(
              "${bestScore ?? 0} / ${widget.topic.questionIDs.length}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: foregroundColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
