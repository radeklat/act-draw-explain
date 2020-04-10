import 'package:act_draw_explain/data/questions.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/models/lastGameResult.dart';
import 'package:act_draw_explain/models/results.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/screens/end_game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExplainScreen extends StatefulWidget {
  static const String ID = "explain_screen";
  final int topicID;

  const ExplainScreen({Key key, @required this.topicID}) : super(key: key);

  @override
  _ExplainScreenState createState() => _ExplainScreenState();
}

class _ExplainScreenState extends State<ExplainScreen> {
  List<int> questionIDs;
  Topic topic;
  int currentQuestionID;
  int score = 0;

  @override
  void initState() {
    super.initState();

    topic = topics[widget.topicID];
    questionIDs = topic.shuffledQuestions;
    currentQuestionID = questionIDs.removeLast();
  }

  void nextQuestion({@required bool passed}) {
    int newScore = (passed) ? score+1 : score;

    try {
      int newQuestionID = questionIDs.removeLast();

      setState(() {
        score = newScore;
        currentQuestionID = newQuestionID;
      });
    } on RangeError {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                    color: Colors.lightGreen,
                    onPressed: () {
                      nextQuestion(passed: true);
                    },
                  ),
                  ProgressButton(
                    title: "Neuhodnuto",
                    iconData: Icons.thumb_down,
                    color: Colors.redAccent,
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

class ProgressButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color color;
  final Function onPressed;

  const ProgressButton({
    Key key,
    @required this.title,
    @required this.iconData,
    @required this.color,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        child: Column(
          children: <Widget>[
            Icon(
              iconData,
              color: color,
              size: 50,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 21),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
