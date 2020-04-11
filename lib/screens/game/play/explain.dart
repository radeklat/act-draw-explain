import 'package:act_draw_explain/data/questions.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/models/lastGameResult.dart';
import 'package:act_draw_explain/models/results.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/screens/game/end_game.dart';
import 'package:act_draw_explain/widgets/countdown_text.dart';
import 'package:act_draw_explain/widgets/progress_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preference_service.dart';

import '../../../constants.dart';

class ExplainScreen extends StatefulWidget {
  static const String ID = "explain_screen";
  final int topicID;

  const ExplainScreen({Key key, @required this.topicID}) : super(key: key);

  @override
  _ExplainScreenState createState() => _ExplainScreenState();
}

class _ExplainScreenState extends State<ExplainScreen> with SingleTickerProviderStateMixin {
  List<int> questionIDs;
  Topic topic;
  int currentQuestionID;
  int score = 0;

  ColorTween backgroundAnimationColorTween = ColorTween(end: K_COLOR_BACKGROUND);
  AnimationController backgroundAnimationController;
  Animation backgroundColorAnimation;
  Color backgroundColor = K_COLOR_BACKGROUND;

  @override
  void initState() {
    super.initState();

    topic = topics[widget.topicID];
    questionIDs = topic.shuffledQuestions;
    currentQuestionID = questionIDs.removeLast();

    backgroundAnimationController = AnimationController(
      duration: K_DURATION_PASS_FAIL_ANIMATION,
      vsync: this,
    )..addListener(() {
        setState(() {
          backgroundColor = backgroundColorAnimation.value;
        });
      });

    backgroundColorAnimation = backgroundAnimationColorTween.animate(backgroundAnimationController);
  }

  @override
  void dispose() {
    backgroundAnimationController.dispose();
    super.dispose();
  }

  void endGame({int newScore}) {
    if (newScore == null) {
      newScore = score;
    }

    Results.recordBestScore(topicID: topic.id, newScore: newScore);
    Navigator.pushNamed(
      context,
      EndGameScreen.ID,
      arguments: LastGameResult(
        questionsCount: topic.questionIDs.length,
        score: newScore,
      ),
    );
  }

  void nextQuestion({@required bool passed}) {
    int newScore = (passed) ? score + 1 : score;

    try {
      int newQuestionID = questionIDs.removeLast();

      setState(() {
        score = newScore;
        currentQuestionID = newQuestionID;
        backgroundAnimationColorTween.begin = (passed) ? K_COLOR_PASS : K_COLOR_FAIL;
        backgroundAnimationController.forward(from: 0);
      });
    } on RangeError {
      endGame(newScore: newScore);
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
                duration: Duration(
                  seconds: PrefService.getInt(K_SETTINGS_GAME_DURATION) ?? K_GAME_DURATION_DEFAULT,
                ),
                onFinished: endGame,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    questions[currentQuestionID].text,
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
                      nextQuestion(passed: true);
                    },
                  ),
                  ProgressButton(
                    title: "Špatně",
                    iconData: Icons.thumb_down,
                    color: K_COLOR_FAIL,
                    onPressed: () {
                      nextQuestion(passed: false);
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
