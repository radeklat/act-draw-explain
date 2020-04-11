import 'package:act_draw_explain/data/questions.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/models/game_result.dart';
import 'package:act_draw_explain/models/results.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/screens/game/end_game.dart';
import 'package:act_draw_explain/widgets/progress_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'explain.dart';

class CountdownScreen extends StatefulWidget {
  static const String ID = "countdown_screen";

  final int topicID;

  const CountdownScreen({Key key, @required this.topicID}) : super(key: key);

  @override
  _ExplainScreenState createState() => _ExplainScreenState();
}

class _ExplainScreenState extends State<CountdownScreen> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  int remainingSeconds = K_DURATION_START_GAME.inSeconds;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: K_DURATION_START_GAME,
      vsync: this,
      upperBound: K_DURATION_START_GAME.inSeconds.toDouble(),
    );
    animationController.addListener(() {
      setState(() {
        remainingSeconds = animationController.value.toInt() + 1;
      });
    });

    animationController
      ..reverse(from: K_DURATION_START_GAME.inSeconds.toDouble())
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          Navigator.pushReplacementNamed(context, ExplainScreen.ID, arguments: widget.topicID);
        }
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

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
                    child: Text(
                      "$remainingSeconds",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: K_COLOR_FONT_PRIMARY, fontSize: K_FONT_SIZE_XX_LARGE),
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
