import 'dart:async';

import 'package:act_draw_explain/controllers/score.dart';
import 'package:act_draw_explain/screens/game/end_game.dart';
import 'package:act_draw_explain/utilities/orientation.dart';
import 'package:act_draw_explain/utilities/sensors.dart';
import 'package:act_draw_explain/widgets/countdown_text.dart';
import 'package:act_draw_explain/widgets/progress_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preference_service.dart';
import 'package:wakelock/wakelock.dart';

import '../../../animations/answer_color.dart';
import '../../../constants.dart';

class ExplainScreen extends StatefulWidget {
  static const String ID = "explain_screen";
  final int topicID;

  const ExplainScreen({Key key, @required this.topicID}) : super(key: key);

  @override
  _ExplainScreenState createState() => _ExplainScreenState();
}

class _ExplainScreenState extends State<ExplainScreen> with SingleTickerProviderStateMixin {
  ScoreController scoreController;
  AnswerColorAnimation answerColorAnimation;

  Color backgroundColor = K_COLOR_BACKGROUND;
  String questionText = "";

  StreamSubscription<dynamic> sensorStream;

  @override
  void initState() {
    super.initState();

    Wakelock.enable();

    if (PrefService.getString(K_SETTINGS_GAME_CONTROL) == K_GAME_CONTROL_SCREEN_TILT) {
      setPreferredOrientationsLandscape();
    } else {
      setPreferredOrientationsAll();
    }

    sensorStream = tiltStream.listen((TiltEvent tilt) {
      nextQuestion(tilt.direction == TiltDirection.down);
    });

    answerColorAnimation = AnswerColorAnimation(
      vsync: this,
      listener: (newColor) {
        setState(() {
          backgroundColor = newColor;
        });
      },
    );
    scoreController = ScoreController(
      topicID: widget.topicID,
      onNextQuestion: (newQuestion) {
        setState(() {
          questionText = newQuestion;
        });
      },
      onGameEnd: (gameResult) {
        cleanUp();
        Navigator.pushNamed(context, EndGameScreen.ID, arguments: gameResult);
      },
    );
  }

  void cleanUp() {
    Wakelock.disable();
    setPreferredOrientationsAll();
    answerColorAnimation?.dispose();
    answerColorAnimation = null;
    sensorStream?.cancel();
    sensorStream = null;
  }

  @override
  void dispose() {
    cleanUp();
    super.dispose();
  }

  void nextQuestion(bool passed) {
      scoreController.nextQuestion(passed: passed);
      if (scoreController.hasMoreQuestions) {
        answerColorAnimation.startAnimation(passed);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          child: Column(
            children: <Widget>[
              CountdownText(
                onFinished: scoreController.endGame,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    questionText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: K_COLOR_FONT_PRIMARY, fontSize: K_FONT_SIZE_X_LARGE),
                    softWrap: true,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  ProgressButton(
                    title: "Správně",
                    iconData: Icons.thumb_up,
                    color: K_COLOR_PASS,
                    value: true,
                    onPressed: nextQuestion,
                  ),
                  ProgressButton(
                    title: "Špatně",
                    iconData: Icons.thumb_down,
                    color: K_COLOR_FAIL,
                    value: false,
                    onPressed: nextQuestion,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
