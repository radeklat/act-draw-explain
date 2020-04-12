import 'package:act_draw_explain/data/questions.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/models/game_result.dart';
import 'package:act_draw_explain/models/results.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/screens/game/end_game.dart';
import 'package:act_draw_explain/widgets/countdown_text.dart';
import 'package:act_draw_explain/widgets/progress_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'explain.dart';

class CountdownScreen extends StatelessWidget {
  static const String ID = "countdown_screen";
  final int topicID;

  const CountdownScreen({Key key, this.topicID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    child: CountdownText(
                      duration: K_DURATION_START_GAME,
                      style: TextStyle(color: K_COLOR_FONT_PRIMARY, fontSize: K_FONT_SIZE_XX_LARGE),
                      onFinished: () {
                        Navigator.pushReplacementNamed(context, ExplainScreen.ID, arguments: topicID);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
