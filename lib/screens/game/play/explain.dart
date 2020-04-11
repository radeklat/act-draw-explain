import 'package:act_draw_explain/controllers/score.dart';
import 'package:act_draw_explain/screens/game/end_game.dart';
import 'package:act_draw_explain/widgets/countdown_text.dart';
import 'package:act_draw_explain/widgets/progress_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preference_service.dart';

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

  @override
  void initState() {
    super.initState();

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
        Navigator.pushNamed(context, EndGameScreen.ID, arguments: gameResult);
      },
    );
  }

  @override
  void dispose() {
    answerColorAnimation.dispose();
    super.dispose();
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
                duration: Duration(
                  seconds: PrefService.getInt(K_SETTINGS_GAME_DURATION) ?? K_GAME_DURATION_DEFAULT,
                ),
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
                    onPressed: () {
                      scoreController.nextQuestion(passed: true);
                      answerColorAnimation.startAnimation(true);
                    },
                  ),
                  ProgressButton(
                    title: "Špatně",
                    iconData: Icons.thumb_down,
                    color: K_COLOR_FAIL,
                    onPressed: () {
                      scoreController.nextQuestion(passed: false);
                      answerColorAnimation.startAnimation(false);
                    },
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
