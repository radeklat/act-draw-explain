import 'package:act_draw_explain/models/game_result.dart';
import 'package:act_draw_explain/screens/topic_selection.dart';
import 'package:act_draw_explain/widgets/one_button_info_screen.dart';
import 'package:flutter/material.dart';

class EndGameScreen extends StatelessWidget {
  static const String ID = "end_game_screen";
  final GameResult lastGameResult;

  const EndGameScreen({Key key, this.lastGameResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OneButtonInfoScreen(
      text: "Konec hry\nUhodnuto ${lastGameResult.score}/${lastGameResult.questionsCount}",
      buttonText: "Zpět na výběr témat",
      onPressed: () {
        Navigator.popUntil(context, ModalRoute.withName(TopicSelectionScreen.ID));
      },
    );
  }
}