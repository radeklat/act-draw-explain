// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a cs locale. All the
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
  String get localeName => 'cs';

  static m0(time) => "${Intl.plural(time, zero: '${time} minut', one: '${time} minuta', few: '${time} minuty', other: '${time} minut')}";

  static m1(time) => "${Intl.plural(time, zero: '${time} sekund', one: '${time} sekunda', few: '${time} sekundy', other: '${time} sekund')}";

  static m2(score, total) => "Uhodnuto ${score}/${total}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "about_changelog_link" : MessageLookupByLibrary.simpleMessage("seznam změn"),
    "about_packages_title" : MessageLookupByLibrary.simpleMessage("Balíčky"),
    "about_sources_title" : MessageLookupByLibrary.simpleMessage("Použité zdroje"),
    "about_title_version" : MessageLookupByLibrary.simpleMessage("Verze aplikace"),
    "button_answer_correct" : MessageLookupByLibrary.simpleMessage("Správně"),
    "button_answer_wrong" : MessageLookupByLibrary.simpleMessage("Špatně"),
    "duration_minutes" : m0,
    "duration_seconds" : m1,
    "duration_unlimited" : MessageLookupByLibrary.simpleMessage("Neomezeně"),
    "end_game_back_button" : MessageLookupByLibrary.simpleMessage("Zpět na výběr témat"),
    "end_game_score" : m2,
    "end_game_title" : MessageLookupByLibrary.simpleMessage("Konec hry"),
    "feedback_device_info_msg" : MessageLookupByLibrary.simpleMessage("Informace o zařízení zkopírována do schránky."),
    "form_validation_positive_int" : MessageLookupByLibrary.simpleMessage("Hodnota musí být celé číslo, větší nebo rovno 0."),
    "game_control_buttons" : MessageLookupByLibrary.simpleMessage("Tlačítky"),
    "game_control_buttons_and_tilt" : MessageLookupByLibrary.simpleMessage("Tlačítky i naklopením"),
    "game_control_screen_tilt" : MessageLookupByLibrary.simpleMessage("Naklopením telefonu"),
    "menu_about" : MessageLookupByLibrary.simpleMessage("O aplikaci"),
    "menu_feedback" : MessageLookupByLibrary.simpleMessage("Zpětná vazba"),
    "menu_feedback_bug_report" : MessageLookupByLibrary.simpleMessage("Nahlásit chybu"),
    "menu_feedback_feature" : MessageLookupByLibrary.simpleMessage("Návrh na vylepšení"),
    "menu_help" : MessageLookupByLibrary.simpleMessage("Nápověda"),
    "menu_settings" : MessageLookupByLibrary.simpleMessage("Nastavení"),
    "name" : MessageLookupByLibrary.simpleMessage("Předveď, Nakresli, Popiš"),
    "settings_game_card_limit" : MessageLookupByLibrary.simpleMessage("Počet karet ve hře (0 = neomezeně)"),
    "settings_game_length" : MessageLookupByLibrary.simpleMessage("Délka hry"),
    "settings_interface_next_question" : MessageLookupByLibrary.simpleMessage("Přechod na další otázku"),
    "settings_interface_vibrations" : MessageLookupByLibrary.simpleMessage("Vibrace ve hře"),
    "settings_title_interface" : MessageLookupByLibrary.simpleMessage("Rozhraní"),
    "settings_title_options" : MessageLookupByLibrary.simpleMessage("Nastavení hry"),
    "start_game_button" : MessageLookupByLibrary.simpleMessage("Start hry"),
    "start_game_prompt" : MessageLookupByLibrary.simpleMessage("Jste připraveni ke hře?")
  };
}