import 'package:act_draw_explain/generated/l10n.dart';
import 'package:act_draw_explain/models/game/result.dart';
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
      text: S.of(context).end_game_title +
          "\n\n" +
          S.of(context).end_game_score(lastGameResult.score, lastGameResult.questionsCount) + "\n",
      buttonText: S.of(context).end_game_back_button,
      key: Key("end_game"),
      onPressed: () {
        Navigator.popUntil(context, ModalRoute.withName(TopicSelectionScreen.ID));
      },
    );
  }
}
