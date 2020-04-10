import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/screens/start_game.dart';
import 'package:flutter/material.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({
    Key key,
    @required this.topic,
  }) : super(key: key);

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: topic.color,
      onPressed: () {
        Navigator.pushNamed(context, StartGameScreen.ID, arguments: topic.id);
      },
      child: Container(
        width: 200,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            topic.icon,
            SizedBox(
              height: 10,
            ),
            Text(
              topic.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
