import 'package:act_draw_explain/models/results.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/screens/start_game.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      color: backgroundColor,
      onPressed: () {
        Navigator.pushNamed(context, StartGameScreen.ID, arguments: widget.topic.id);
      },
      child: Stack(
        children: <Widget>[
          TopicNameIcon(foregroundColor: foregroundColor, topic: widget.topic),
          TopicCounter(
            alignment: Alignment.topRight,
            value: "${bestScore ?? 0}/${widget.topic.questionIDs.length}",
            foregroundColor: foregroundColor,
          ),
        ],
      ),
    );
  }
}

class TopicNameIcon extends StatelessWidget {
  const TopicNameIcon({
    Key key,
    @required this.foregroundColor,
    @required this.topic,
  }) : super(key: key);

  final Color foregroundColor;
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            topic.icon.icon,
            size: 50,
            color: foregroundColor.withOpacity(0.8),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            constraints: BoxConstraints(maxHeight: 50),
            child: AutoSizeText(
              topic.name,
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500, color: foregroundColor),
              textAlign: TextAlign.center,
              maxLines: 3,
              minFontSize: 12,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}

class TopicCounter extends StatelessWidget {
  const TopicCounter({
    Key key,
    @required this.value,
    @required this.foregroundColor,
    this.alignment,
  }) : super(key: key);

  final String value;
  final Color foregroundColor;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: EdgeInsets.all(5),
      child: Text(
        value,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: foregroundColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
