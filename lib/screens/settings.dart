import 'package:act_draw_explain/data/game.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/utilities/settings.dart';
import 'package:act_draw_explain/widgets/topic_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprintf/sprintf.dart';

import '../constants.dart';

class SettingsScreen extends StatefulWidget {
  static const String ID = "settings_screen";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SettingsList(),
      ),
    );
  }
}

class SettingsList extends StatefulWidget {
  const SettingsList({Key key}) : super(key: key);

  @override
  _SettingsListState createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  SharedPreferences prefs;
  int currentDelay;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        prefs = value;
        currentDelay = getCurrentGameDuration(prefs);
      });
    });
    currentDelay = getCurrentGameDuration(prefs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(
            "Délka hry",
            style: TextStyle(fontSize: K_FONT_SIZE_NORMAL),
          ),
          leading: Icon(
            Icons.timer,
            color: K_COLOR_ICON,
            size: K_SIZE_ICON,
          ),
          trailing: DropdownButton(
            items: K_DURATIONS_PLAY_GAME
                .map(
                  (duration) => DropdownMenuItem(
                    key: Key(duration.toString()),
                    value: duration,
                    child: Text(
                      (duration > 0) ? sprintf("%d:%02d", [duration ~/ 60, duration % 60]) : "Neomezeně",
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                prefs.setInt(K_SETTINGS_GAME_DURATION, value);
                currentDelay = value;
              });
            },
            value: currentDelay,
          ),
          enabled: prefs != null,
        ),
      ],
    );
  }
}
