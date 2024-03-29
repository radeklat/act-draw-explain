import 'package:act_draw_explain/constants.dart';
import 'package:act_draw_explain/models/game/new.dart';
import 'package:act_draw_explain/models/results.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'file:///D:/projekty/flutter/act-draw-explain/lib/screens/game/play/activity/activity.dart';
import 'package:act_draw_explain/screens/game/play/heads_up.dart';
import 'package:act_draw_explain/screens/game/start_game.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preference_service.dart';
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
            Navigator.pushNamed(
              context,
              StartGameScreen.ID,
              arguments: NewGame(topic, PrefService.getString(K.settings.game.type.key) ?? K.settings.game.type.defaultValue),
            );
          },
          child: Stack(
            children: <Widget>[
              TopicNameIcon(foregroundColor: foregroundColor, topic: topic),
              TopicCounter(
                alignment: Alignment.topRight,
                valueTop: "${bestScore ?? 0}",
                valueBottom: "${topic.length(Localizations.localeOf(context))}",
                foregroundColor: foregroundColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
