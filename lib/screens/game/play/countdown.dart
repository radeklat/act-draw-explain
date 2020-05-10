import 'package:act_draw_explain/controllers/score.dart';
import 'package:act_draw_explain/utilities/vibrations.dart';
import 'package:act_draw_explain/widgets/countdown_text.dart';
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
                      style: Theme.of(context).textTheme.headline1,
                      onFinished: () {
                        GameSounds.gameStart();
                        GameVibrations.gameStart();
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
