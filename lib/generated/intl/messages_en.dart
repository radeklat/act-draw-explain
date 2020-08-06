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
    "activity_act" : MessageLookupByLibrary.simpleMessage("Act out"),
    "activity_draw" : MessageLookupByLibrary.simpleMessage("Draw"),
    "activity_explain" : MessageLookupByLibrary.simpleMessage("Explain"),
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
    "help_advanced_game_par_1" : MessageLookupByLibrary.simpleMessage("Although the application does not yet prompt this and has not optimized question selection process, it is possible to guess by demonstration (pantomime) or drawing."),
    "help_advanced_game_title" : MessageLookupByLibrary.simpleMessage("Advanced games"),
    "help_game_control_blind_par_1" : MessageLookupByLibrary.simpleMessage("One of the players guesses the term and does not see it, the others see it and try to describe it. Whether the answer was correct or incorrect can be indicated by tilting the phone."),
    "help_game_control_blind_title" : MessageLookupByLibrary.simpleMessage("Blind"),
    "help_game_control_narrator_par_1" : MessageLookupByLibrary.simpleMessage("One of the players sees the guessed term and describes it, the others do not see and guess it. The answer can be marked with the buttons."),
    "help_game_control_narrator_title" : MessageLookupByLibrary.simpleMessage("Narrator"),
    "help_game_control_score_par_1" : MessageLookupByLibrary.simpleMessage("In the settings, select an unlimited length of play. The game lasts until the time run out. Who has the most correct answers?"),
    "help_game_control_score_title" : MessageLookupByLibrary.simpleMessage("Highest score"),
    "help_game_control_time_par_1" : MessageLookupByLibrary.simpleMessage("Select the length of the game in the settings. Who will get the most answers in the time limit?"),
    "help_game_control_time_title" : MessageLookupByLibrary.simpleMessage("Time limited"),
    "help_game_control_title" : MessageLookupByLibrary.simpleMessage("Game styles"),
    "help_how_to_play_buttons_par_1" : MessageLookupByLibrary.simpleMessage("The correct and wrong answer buttons are displayed on the guessing screen."),
    "help_how_to_play_par_1" : MessageLookupByLibrary.simpleMessage("The game is designed for 2 or more players. In case of multiple players, it is possible to divide into several teams of at least two players. The principle of the game is to guess as many terms as possible. Words with the same root as the guessed term must not be used. The guessing player can try until they answer correctly. However, if the game is time limited or the term is too difficult, it is possible to skip it."),
    "help_how_to_play_par_2" : MessageLookupByLibrary.simpleMessage("The method of answering questions can be changed in the settings."),
    "help_how_to_play_tilt_par_1" : MessageLookupByLibrary.simpleMessage("The phone should placed on you forehead. The correct answer is chosen by tilting the display down, the wrong one by tilting up."),
    "help_how_to_play_title" : MessageLookupByLibrary.simpleMessage("How to play"),
    "loading_data" : MessageLookupByLibrary.simpleMessage("Loading game data"),
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
    "settings_language" : MessageLookupByLibrary.simpleMessage("Language"),
    "settings_language_description" : MessageLookupByLibrary.simpleMessage("Affects app UI, topics and questions"),
    "settings_title_interface" : MessageLookupByLibrary.simpleMessage("Interface"),
    "settings_title_languages" : MessageLookupByLibrary.simpleMessage("Languages"),
    "settings_title_options" : MessageLookupByLibrary.simpleMessage("Game options"),
    "start_game_button" : MessageLookupByLibrary.simpleMessage("Start game"),
    "start_game_prompt" : MessageLookupByLibrary.simpleMessage("Are you ready to play?")
  };
}
