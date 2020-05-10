import 'package:act_draw_explain/analytics.dart';
import 'package:act_draw_explain/utilities/vibrations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class SettingsScreen extends StatefulWidget {
  static const String ID = "settings_screen";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void onChange(String settingsKey) {
    final allSettings = {
      K_SETTINGS_GAME_DURATION: PrefService.getInt(K_SETTINGS_GAME_DURATION) ?? K_GAME_DURATION_DEFAULT,
      K_SETTINGS_GAME_CARDS_COUNT: PrefService.getString(K_SETTINGS_GAME_CARDS_COUNT) ?? K_GAME_CARDS_COUNT_DEFAULT,
      K_SETTINGS_GAME_CONTROL: PrefService.getString(K_SETTINGS_GAME_CONTROL) ?? K_GAME_CONTROL_DEFAULT,
      K_SETTINGS_GAME_VIBRATE: PrefService.getBool(K_SETTINGS_GAME_VIBRATE) ?? K_GAME_VIBRATE_DEFAULT,
    }.map((key, value) => MapEntry(key.replaceAll(".", "_"), value));

    Provider.of<Analytics>(context, listen: false).settingsChanged(settingsKey.replaceAll(".", "_"), allSettings);
  }

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
              onChange: (_val) => this.onChange(K_SETTINGS_GAME_DURATION),
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
              onChange: (_val) => this.onChange(K_SETTINGS_GAME_CARDS_COUNT),
            ),
            PreferenceTitle('Rozhraní'),
            DropdownPreference(
              'Přechod na další otázku',
              K_SETTINGS_GAME_CONTROL,
              defaultVal: K_GAME_CONTROL_DEFAULT,
              values: K_GAME_CONTROL_VALUES,
              displayValues: K_GAME_CONTROL_DISPLAY,
              onChange: (_val) => this.onChange(K_SETTINGS_GAME_CONTROL),
            ),
            SwitchPreference(
              'Vibrace ve hře',
              K_SETTINGS_GAME_VIBRATE,
              defaultVal: K_GAME_VIBRATE_DEFAULT,
              disabled: !GameVibrations.hasVibrator,
              onChange: () => this.onChange(K_SETTINGS_GAME_VIBRATE),
            ),
          ],
        ),
      ),
    );
  }
}
