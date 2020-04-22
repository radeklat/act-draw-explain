import 'package:act_draw_explain/utilities/vibrations.dart';
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
            TextFieldPreference(
              "Počet karet ve hře (0 = neomezeně)",
              K_SETTINGS_GAME_CARDS_COUNT,
              defaultVal: K_GAME_CARDS_COUNT_DEFAULT.toString(),
              keyboardType: TextInputType.numberWithOptions(),
              validator: (value) {
                try {
                  if (int.parse(value) < 0) throw FormatException;
                } catch (FormatException) {
                  return "Hodnota musí být celé číslo, větší nebo rovno 0.";
                }

                return null;
              },
            ),
            PreferenceTitle('Rozhraní'),
            DropdownPreference(
              'Přechod na další otázku',
              K_SETTINGS_GAME_CONTROL,
              defaultVal: K_GAME_CONTROL_DEFAULT,
              values: K_GAME_CONTROL_VALUES,
              displayValues: K_GAME_CONTROL_DISPLAY,
            ),
            SwitchPreference(
              'Vibrace ve hře',
              K_SETTINGS_GAME_VIBRATE,
              defaultVal: K_GAME_VIBRATE_DEFAULT,
              disabled: !GameVibrations.hasVibrator,
            ),
          ],
        ),
      ),
    );
  }
}
