import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../constants.dart';

class SettingsScreen extends StatelessWidget {
  static const String ID = "settings_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PreferencePage(
          [
            PreferenceTitle('Nastavení hry'),
            DropdownPreference(
              'Délka hry',
              K_SETTINGS_GAME_DURATION,
              defaultVal: K_GAME_DURATION_DEFAULT,
              values: K_GAME_DURATION_VALUES,
              displayValues: K_GAME_DURATION_DISPLAY,
            ),
            DropdownPreference(
              'Ovládání',
              K_SETTINGS_GAME_CONTROL,
              desc: "Přechod na další otázku",
              defaultVal: K_GAME_CONTROL_DEFAULT,
              values: K_GAME_CONTROL_VALUES,
              displayValues: K_GAME_CONTROL_DISPLAY,
            ),
          ],
        ),
      ),
    );
  }
}
