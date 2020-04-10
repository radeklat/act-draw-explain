import 'package:act_draw_explain/data/questions.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/models/lastGameResult.dart';
import 'package:act_draw_explain/models/results.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/screens/end_game.dart';
import 'package:act_draw_explain/widgets/progress_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExplainScreen extends StatefulWidget {
  static const String ID = "explain_screen";
  final int topicID;

  final Color passColor = Colors.lightGreen;
  final Color failColor = Colors.red;

  const ExplainScreen({Key key, @required this.topicID}) : super(key: key);

  @override
  _ExplainScreenState createState() => _ExplainScreenState();
}

class _ExplainScreenState extends State<ExplainScreen> with SingleTickerProviderStateMixin {
  List<int> questionIDs;
  Topic topic;
  int currentQuestionID;
  int score = 0;

  ColorTween backgroundAnimationColorTween = ColorTween(end: Colors.white);
  AnimationController backgroundAnimationController;
  Animation backgroundColorAnimation;
  Color backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();

    topic = topics[widget.topicID];
    questionIDs = topic.shuffledQuestions;
    currentQuestionID = questionIDs.removeLast();

    backgroundAnimationController = AnimationController(
      duration: Duration(seconds: 2),
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

  void endGame(int newScore) {
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
        backgroundAnimationColorTween.begin = (passed) ? Colors.lightGreen : Colors.redAccent;
        backgroundAnimationController.forward(from: 0);
      });
    } on RangeError {
      endGame(newScore);
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
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    questions[currentQuestionID].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black87, fontSize: 92),
                    softWrap: true,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  ProgressButton(
                    title: "Uhodnuto",
                    iconData: Icons.thumb_up,
                    color: widget.passColor,
                    onPressed: () {
                      nextQuestion(passed: true);
                    },
                  ),
                  ProgressButton(
                    title: "Neuhodnuto",
                    iconData: Icons.thumb_down,
                    color: widget.failColor,
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
