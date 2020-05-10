import 'dart:async';

import 'package:act_draw_explain/controllers/score.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/models/results.dart';
import 'package:act_draw_explain/screens/game/end_game.dart';
import 'package:act_draw_explain/utilities/orientation.dart';
import 'package:act_draw_explain/utilities/sensors.dart';
import 'package:act_draw_explain/widgets/countdown_text.dart';
import 'package:act_draw_explain/widgets/progress_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preference_service.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

import '../../../analytics.dart';
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
  bool showButtons = true;

  Color backgroundColor = K_COLOR_BACKGROUND;
  String questionText = "";
  Duration gameDuration;

  StreamSubscription<dynamic> sensorStream;

  void initGameControl() {
    final String gameControlType = PrefService.getString(K_SETTINGS_GAME_CONTROL);

    if (gameControlType == K_GAME_CONTROL_SCREEN_TILT) {
      setPreferredOrientationsLandscape();
      showButtons = false;
    } else {
      setPreferredOrientationsAll();
    }

    if (gameControlType != K_GAME_CONTROL_BUTTONS) {
      sensorStream = tiltStream.listen((TiltEvent tilt) {
        nextQuestion(tilt.direction == TiltDirection.down);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    Wakelock.enable();
    initGameControl();

    gameDuration = Duration(
      seconds: PrefService.getInt(K_SETTINGS_GAME_DURATION) ?? K_GAME_DURATION_DEFAULT,
    );

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
      logQuestion: (topic, question, duration, state) =>
          Provider.of<Analytics>(context, listen: false).playedQuestion(topic, question, duration, state, gameDuration),
      onGameEnd: (gameResult) {
        Provider.of<Analytics>(context, listen: false).playedGame(topics[widget.topicID], gameDuration, gameResult);
        Navigator.pushReplacementNamed(context, EndGameScreen.ID, arguments: gameResult);
      },
      setNewScore: (newScore) {
        Provider.of<TopicBestScore>(context, listen: false).record(topicID: widget.topicID, newScore: newScore);
      },
      maxQuestions: int.parse(PrefService.getString(K_SETTINGS_GAME_CARDS_COUNT) ?? "$K_GAME_CARDS_COUNT_DEFAULT"),
    );
  }

  @override
  void dispose() {
    Wakelock.disable();
    setPreferredOrientationsAll();
    answerColorAnimation?.dispose();
    sensorStream?.cancel();
    super.dispose();
  }

  void nextQuestion(bool passed) {
    scoreController.nextQuestion(passed: passed);

    if (scoreController.hasMoreQuestions) answerColorAnimation.startAnimation(passed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (gameDuration.inSeconds > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CountdownText(
                      onFinished: scoreController.endGame,
                      duration: gameDuration,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: AutoSizeText(
                          questionText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline2,
                          minFontSize: Theme.of(context).textTheme.headline5.fontSize,
                          wrapWords: false,
                          maxLines: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (showButtons)
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
                ),
            ],
          ),
        ),
      ),
    );
  }
}
