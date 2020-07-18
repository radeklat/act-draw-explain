import 'package:act_draw_explain/analytics.dart';
import 'package:act_draw_explain/generated/l10n.dart';
import 'package:act_draw_explain/utilities/intl.dart';
import 'package:act_draw_explain/utilities/vibrations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  static const String ID = "settings_screen";
  final List<Locale> supportedLocales;

  const SettingsScreen({Key key, this.supportedLocales}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void onChange(KeyDefault setting) {
    final allSettings = {
      K.settings.game.duration: PrefService.getInt,
      K.settings.game.cardsCount: PrefService.getString,
      K.settings.game.control: PrefService.getString,
      K.settings.game.vibrate: PrefService.getBool,
      K.settings.locales: PrefService.getString
    }.map(
      (_setting, getFunc) => MapEntry(
        _setting.keyUnderscored,
        getFunc(_setting.key) ?? _setting.defaultValue,
      ),
    );

    Provider.of<Analytics>(context, listen: false).settingsChanged(setting.keyUnderscored, allSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PreferencePage(
          [
            PreferenceTitle(S.of(context).settings_title_languages),
            DropdownPreference(
              S.of(context).settings_language,
              K.settings.locales.key,
              desc: S.of(context).settings_language_description,
              defaultVal: Localizations.localeOf(context).toString(),
              values: widget.supportedLocales.map((locale) => locale.languageCode).toList(),
              displayValues: widget.supportedLocales
                  .map((locale) => isoLanguages[locale.languageCode].nativeName)
                  .toList(),
              onChange: (languageCode) {
                MyApp.setLocale(context, Locale(languageCode));
                this.onChange(K.settings.locales);
              },
            ),
            PreferenceTitle(S.of(context).settings_title_options),
            DropdownPreference(
              S.of(context).settings_game_length,
              K.settings.game.duration.key,
              defaultVal: K.settings.game.duration.defaultValue,
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
              onChange: (_val) => this.onChange(K.settings.game.duration),
            ),
            TextFieldPreference(
              S.of(context).settings_game_card_limit,
              K.settings.game.cardsCount.key,
              defaultVal: K.settings.game.cardsCount.defaultValue.toString(),
              keyboardType: TextInputType.numberWithOptions(),
              validator: (value) {
                try {
                  if (int.parse(value) < 0) throw FormatException;
                } catch (FormatException) {
                  return S.of(context).form_validation_positive_int;
                }

                return null;
              },
              onChange: (_val) => this.onChange(K.settings.game.cardsCount),
            ),
            PreferenceTitle(S.of(context).settings_title_interface),
            DropdownPreference(
              S.of(context).settings_interface_next_question,
              K.settings.game.control.key,
              defaultVal: K.settings.game.control.defaultValue,
              values: K_GAME_CONTROL_VALUES,
              displayValues: [
                S.of(context).game_control_buttons,
                S.of(context).game_control_screen_tilt,
                S.of(context).game_control_buttons_and_tilt,
              ],
              onChange: (_val) => this.onChange(K.settings.game.control),
            ),
            SwitchPreference(
              S.of(context).settings_interface_vibrations,
              K.settings.game.vibrate.key,
              defaultVal: K.settings.game.vibrate.defaultValue,
              disabled: !GameVibrations.hasVibrator,
              onChange: () => this.onChange(K.settings.game.vibrate),
            ),
          ],
        ),
      ),
    );
  }
}
