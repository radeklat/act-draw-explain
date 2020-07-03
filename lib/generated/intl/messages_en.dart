// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(time) => "${Intl.plural(time, zero: '${time} minutes', one: '${time} minute', other: '${time} minutes')}";

  static m1(time) => "${Intl.plural(time, zero: '${time} seconds', one: '${time} second', other: '${time} seconds')}";

  static m2(score, total) => "Guessed ${score}/${total}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "about_changelog_link" : MessageLookupByLibrary.simpleMessage("change log"),
    "about_packages_title" : MessageLookupByLibrary.simpleMessage("Packages"),
    "about_sources_title" : MessageLookupByLibrary.simpleMessage("Sources"),
    "about_title_version" : MessageLookupByLibrary.simpleMessage("Application version"),
    "button_answer_correct" : MessageLookupByLibrary.simpleMessage("Correct"),
    "button_answer_wrong" : MessageLookupByLibrary.simpleMessage("Wrong"),
    "duration_minutes" : m0,
    "duration_seconds" : m1,
    "duration_unlimited" : MessageLookupByLibrary.simpleMessage("Unlimited"),
    "end_game_back_button" : MessageLookupByLibrary.simpleMessage("Back to topic selection"),
    "end_game_score" : m2,
    "end_game_title" : MessageLookupByLibrary.simpleMessage("Game ended"),
    "feedback_device_info_msg" : MessageLookupByLibrary.simpleMessage("Device info has been copied to the clipboard"),
    "form_validation_positive_int" : MessageLookupByLibrary.simpleMessage("Value must be an integer, higher or equal to 0."),
    "game_control_buttons" : MessageLookupByLibrary.simpleMessage("Buttons"),
    "game_control_buttons_and_tilt" : MessageLookupByLibrary.simpleMessage("Buttons and screen tilt"),
    "game_control_screen_tilt" : MessageLookupByLibrary.simpleMessage("Screen tilt"),
    "help_advanced_game_par_1" : MessageLookupByLibrary.simpleMessage(""),
    "help_advanced_game_title" : MessageLookupByLibrary.simpleMessage(""),
    "help_game_control_blind_par_1" : MessageLookupByLibrary.simpleMessage(""),
    "help_game_control_blind_title" : MessageLookupByLibrary.simpleMessage(""),
    "help_game_control_narrator_par_1" : MessageLookupByLibrary.simpleMessage(""),
    "help_game_control_narrator_title" : MessageLookupByLibrary.simpleMessage(""),
    "help_game_control_score_par_1" : MessageLookupByLibrary.simpleMessage(""),
    "help_game_control_score_title" : MessageLookupByLibrary.simpleMessage(""),
    "help_game_control_time_par_1" : MessageLookupByLibrary.simpleMessage(""),
    "help_game_control_time_title" : MessageLookupByLibrary.simpleMessage(""),
    "help_game_control_title" : MessageLookupByLibrary.simpleMessage(""),
    "help_how_to_play_buttons_par_1" : MessageLookupByLibrary.simpleMessage(""),
    "help_how_to_play_par_1" : MessageLookupByLibrary.simpleMessage(""),
    "help_how_to_play_par_2" : MessageLookupByLibrary.simpleMessage(""),
    "help_how_to_play_tilt_par_1" : MessageLookupByLibrary.simpleMessage(""),
    "help_how_to_play_title" : MessageLookupByLibrary.simpleMessage("How to play"),
    "menu_about" : MessageLookupByLibrary.simpleMessage("About"),
    "menu_feedback" : MessageLookupByLibrary.simpleMessage("Feedback"),
    "menu_feedback_bug_report" : MessageLookupByLibrary.simpleMessage("Report a bug"),
    "menu_feedback_feature" : MessageLookupByLibrary.simpleMessage("Feature request"),
    "menu_help" : MessageLookupByLibrary.simpleMessage("Help"),
    "menu_settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "name" : MessageLookupByLibrary.simpleMessage("Act, Draw, Explain"),
    "settings_game_card_limit" : MessageLookupByLibrary.simpleMessage("Number of card in game (0 = unlimited)"),
    "settings_game_length" : MessageLookupByLibrary.simpleMessage("Game length"),
    "settings_interface_next_question" : MessageLookupByLibrary.simpleMessage("Next question control"),
    "settings_interface_vibrations" : MessageLookupByLibrary.simpleMessage("In-game vibration"),
    "settings_title_interface" : MessageLookupByLibrary.simpleMessage("Interface"),
    "settings_title_options" : MessageLookupByLibrary.simpleMessage("Game options"),
    "start_game_button" : MessageLookupByLibrary.simpleMessage("Start game"),
    "start_game_prompt" : MessageLookupByLibrary.simpleMessage("Are you ready to play?")
  };
}
