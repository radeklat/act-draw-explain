import 'package:act_draw_explain/generated/l10n.dart';
import 'package:act_draw_explain/models/game/new.dart';
import 'package:act_draw_explain/screens/game/play/countdown.dart';
import 'package:act_draw_explain/widgets/one_button_info_screen.dart';
import 'package:flutter/material.dart';

class StartGameScreen extends StatelessWidget {
  static const String ID = "start_game_screen";
  final NewGame newGame;

  const StartGameScreen({Key key, this.newGame}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OneButtonInfoScreen(
      text: S.of(context).start_game_prompt,
      buttonText: S.of(context).start_game_button,
      key: Key("start_game"),
      onPressed: () {
        Navigator.pushReplacementNamed(context, CountdownScreen.ID, arguments: newGame);
      },
    );
  }
}
