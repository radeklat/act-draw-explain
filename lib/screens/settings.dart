import 'package:act_draw_explain/analytics.dart';
import 'package:act_draw_explain/generated/l10n.dart';
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
            PreferenceTitle(S.of(context).settings_title_options),
            DropdownPreference(
              S.of(context).settings_game_length,
              K_SETTINGS_GAME_DURATION,
              defaultVal: K_GAME_DURATION_DEFAULT,
              values: K_GAME_DURATION_VALUES,
              displayValues: [
                S.of(context).duration_seconds(K_GAME_DURATION_VALUES[0]),
                S.of(context).duration_seconds(K_GAME_DURATION_VALUES[1]),
                S.of(context).duration_seconds(K_GAME_DURATION_VALUES[2]),
                S.of(context).duration_minutes(K_GAME_DURATION_VALUES[3] ~/ 60),
                S.of(context).duration_minutes(K_GAME_DURATION_VALUES[4] ~/ 60),
                S.of(context).duration_minutes(K_GAME_DURATION_VALUES[5] ~/ 60),
                S.of(context).duration_unlimited,
              ],
              onChange: (_val) => this.onChange(K_SETTINGS_GAME_DURATION),
            ),
            TextFieldPreference(
              S.of(context).settings_game_card_limit,
              K_SETTINGS_GAME_CARDS_COUNT,
              defaultVal: K_GAME_CARDS_COUNT_DEFAULT.toString(),
              keyboardType: TextInputType.numberWithOptions(),
              validator: (value) {
                try {
                  if (int.parse(value) < 0) throw FormatException;
                } catch (FormatException) {
                  return S.of(context).form_validation_positive_int;
                }

                return null;
              },
              onChange: (_val) => this.onChange(K_SETTINGS_GAME_CARDS_COUNT),
            ),
            PreferenceTitle(S.of(context).settings_title_interface),
            DropdownPreference(
              S.of(context).settings_interface_next_question,
              K_SETTINGS_GAME_CONTROL,
              defaultVal: K_GAME_CONTROL_DEFAULT,
              values: K_GAME_CONTROL_VALUES,
              displayValues: [
                S.of(context).game_control_buttons,
                S.of(context).game_control_screen_tilt,
                S.of(context).game_control_buttons_and_tilt,
              ],
              onChange: (_val) => this.onChange(K_SETTINGS_GAME_CONTROL),
            ),
            SwitchPreference(
              S.of(context).settings_interface_vibrations,
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
