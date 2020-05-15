import 'package:act_draw_explain/screens/game/play/countdown.dart';
import 'package:act_draw_explain/widgets/one_button_info_screen.dart';
import 'package:flutter/material.dart';

class StartGameScreen extends StatelessWidget {
  static const String ID = "start_game_screen";
  final int topicID;

  const StartGameScreen({Key key, this.topicID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OneButtonInfoScreen(
      text: "Jste připraveni ke hře?",
      buttonText: "Start hry",
      key: Key("start_game"),
      onPressed: () {
        Navigator.pushReplacementNamed(context, CountdownScreen.ID, arguments: topicID);
      },
    );
  }
}
