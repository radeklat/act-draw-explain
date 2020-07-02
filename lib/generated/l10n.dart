// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Act, Draw, Explain`
  String get name {
    return Intl.message(
      'Act, Draw, Explain',
      name: 'name',
      desc: 'Name of the app',
      args: [],
    );
  }

  /// `Buttons`
  String get game_control_buttons {
    return Intl.message(
      'Buttons',
      name: 'game_control_buttons',
      desc: 'Settings / Game control / Buttons',
      args: [],
    );
  }

  /// `Screen tilt`
  String get game_control_screen_tilt {
    return Intl.message(
      'Screen tilt',
      name: 'game_control_screen_tilt',
      desc: 'Settings / Game control / Screen tilt',
      args: [],
    );
  }

  /// `Buttons and screen tilt`
  String get game_control_buttons_and_tilt {
    return Intl.message(
      'Buttons and screen tilt',
      name: 'game_control_buttons_and_tilt',
      desc: 'Settings / Game control / Buttons and screen tilt',
      args: [],
    );
  }

  /// `Game options`
  String get settings_title_options {
    return Intl.message(
      'Game options',
      name: 'settings_title_options',
      desc: 'Settings title for game options',
      args: [],
    );
  }

  /// `Game length`
  String get settings_game_length {
    return Intl.message(
      'Game length',
      name: 'settings_game_length',
      desc: 'Settings description for game length',
      args: [],
    );
  }

  /// `{time,plural, =0{{time} seconds} =1{{time} second} other{{time} seconds}}`
  String duration_seconds(num time) {
    return Intl.plural(
      time,
      zero: '$time seconds',
      one: '$time second',
      other: '$time seconds',
      name: 'duration_seconds',
      desc: 'Duration in seconds',
      args: [time],
    );
  }

  /// `{time,plural, =0{{time} minutes} =1{{time} minute} other{{time} minutes}}`
  String duration_minutes(num time) {
    return Intl.plural(
      time,
      zero: '$time minutes',
      one: '$time minute',
      other: '$time minutes',
      name: 'duration_minutes',
      desc: 'Duration in minutes',
      args: [time],
    );
  }

  /// `Unlimited`
  String get duration_unlimited {
    return Intl.message(
      'Unlimited',
      name: 'duration_unlimited',
      desc: 'Unlimited time duration',
      args: [],
    );
  }

  /// `Number of card in game (0 = unlimited)`
  String get settings_game_card_limit {
    return Intl.message(
      'Number of card in game (0 = unlimited)',
      name: 'settings_game_card_limit',
      desc: 'Settings description for game cards limits',
      args: [],
    );
  }

  /// `Value must be an integer, higher or equal to 0.`
  String get form_validation_positive_int {
    return Intl.message(
      'Value must be an integer, higher or equal to 0.',
      name: 'form_validation_positive_int',
      desc: 'Validation message for positive int',
      args: [],
    );
  }

  /// `Interface`
  String get settings_title_interface {
    return Intl.message(
      'Interface',
      name: 'settings_title_interface',
      desc: 'Settings title for interface',
      args: [],
    );
  }

  /// `Next question control`
  String get settings_interface_next_question {
    return Intl.message(
      'Next question control',
      name: 'settings_interface_next_question',
      desc: 'Settings description for next questions control drop down box',
      args: [],
    );
  }

  /// `In-game vibration`
  String get settings_interface_vibrations {
    return Intl.message(
      'In-game vibration',
      name: 'settings_interface_vibrations',
      desc: 'Settings description for in-game vibrations',
      args: [],
    );
  }

  /// `Application version`
  String get about_title_version {
    return Intl.message(
      'Application version',
      name: 'about_title_version',
      desc: 'About screen, application version title',
      args: [],
    );
  }

  /// `change log`
  String get about_changelog_link {
    return Intl.message(
      'change log',
      name: 'about_changelog_link',
      desc: 'About screen, external link to change log',
      args: [],
    );
  }

  /// `Sources`
  String get about_sources_title {
    return Intl.message(
      'Sources',
      name: 'about_sources_title',
      desc: 'About screen, title for sources',
      args: [],
    );
  }

  /// `Packages`
  String get about_packages_title {
    return Intl.message(
      'Packages',
      name: 'about_packages_title',
      desc: 'About screen, title for packages',
      args: [],
    );
  }

  /// `Device info has been copied to the clipboard`
  String get feedback_device_info_msg {
    return Intl.message(
      'Device info has been copied to the clipboard',
      name: 'feedback_device_info_msg',
      desc: 'Toast message displayed when feedback form is opened',
      args: [],
    );
  }

  /// `Feedback`
  String get menu_feedback {
    return Intl.message(
      'Feedback',
      name: 'menu_feedback',
      desc: 'Main menu button and dialog title',
      args: [],
    );
  }

  /// `Feature request`
  String get menu_feedback_feature {
    return Intl.message(
      'Feature request',
      name: 'menu_feedback_feature',
      desc: 'Main sub-menu button',
      args: [],
    );
  }

  /// `Report a bug`
  String get menu_feedback_bug_report {
    return Intl.message(
      'Report a bug',
      name: 'menu_feedback_bug_report',
      desc: 'Main sub-menu button',
      args: [],
    );
  }

  /// `Settings`
  String get menu_settings {
    return Intl.message(
      'Settings',
      name: 'menu_settings',
      desc: 'Main menu button',
      args: [],
    );
  }

  /// `Help`
  String get menu_help {
    return Intl.message(
      'Help',
      name: 'menu_help',
      desc: 'Main menu button',
      args: [],
    );
  }

  /// `About`
  String get menu_about {
    return Intl.message(
      'About',
      name: 'menu_about',
      desc: 'Main menu button',
      args: [],
    );
  }

  /// `Are you ready to play?`
  String get start_game_prompt {
    return Intl.message(
      'Are you ready to play?',
      name: 'start_game_prompt',
      desc: 'Start game screen prompt',
      args: [],
    );
  }

  /// `Start game`
  String get start_game_button {
    return Intl.message(
      'Start game',
      name: 'start_game_button',
      desc: 'Button to start the game on the start game screen',
      args: [],
    );
  }

  /// `Game ended`
  String get end_game_title {
    return Intl.message(
      'Game ended',
      name: 'end_game_title',
      desc: 'Title of the game end screen',
      args: [],
    );
  }

  /// `Guessed {score}/{total}`
  String end_game_score(Object score, Object total) {
    return Intl.message(
      'Guessed $score/$total',
      name: 'end_game_score',
      desc: 'Score in a sentence on the game end screen',
      args: [score, total],
    );
  }

  /// `Back to topic selection`
  String get end_game_back_button {
    return Intl.message(
      'Back to topic selection',
      name: 'end_game_back_button',
      desc: 'Button to get back to topic selections screen from the end game screen',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'cs'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}