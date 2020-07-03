import 'package:act_draw_explain/generated/l10n.dart';
import 'package:act_draw_explain/widgets/text.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  static const String ID = "help_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            TextCard(
              children: <Widget>[
                TextTitle(S.of(context).help_how_to_play_title),
                TextBody1(S.of(context).help_how_to_play_par_1),
                TextBody1(S.of(context).help_how_to_play_par_2),
                TextSubtitle(S.of(context).game_control_buttons),
                TextBody1(S.of(context).help_how_to_play_buttons_par_1),
                TextSubtitle(S.of(context).game_control_screen_tilt),
                TextBody1(S.of(context).help_how_to_play_tilt_par_1),
              ],
            ),
            TextCard(
              children: <Widget>[
                TextTitle(S.of(context).help_game_control_title),
                TextSubtitle(S.of(context).help_game_control_blind_title),
                TextBody1(S.of(context).help_game_control_blind_par_1),
                TextSubtitle(S.of(context).help_game_control_narrator_title),
                TextBody1(S.of(context).help_game_control_narrator_par_1),
                TextSubtitle(S.of(context).help_game_control_time_title),
                TextBody1(S.of(context).help_game_control_time_par_1),
                TextSubtitle(S.of(context).help_game_control_score_title),
                TextBody1(S.of(context).help_game_control_score_par_1),
              ],
            ),
            TextCard(
              children: <Widget>[
                TextTitle(S.of(context).help_advanced_game_title),
                TextBody1(S.of(context).help_advanced_game_par_1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
