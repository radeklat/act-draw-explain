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
    "feedback_device_info_msg" : MessageLookupByLibrary.simpleMessage("Informace o zařízení zkopírována do schránky"),
    "form_validation_positive_int" : MessageLookupByLibrary.simpleMessage("Hodnota musí být celé číslo, větší nebo rovno 0."),
    "game_control_buttons" : MessageLookupByLibrary.simpleMessage("Tlačítky"),
    "game_control_buttons_and_tilt" : MessageLookupByLibrary.simpleMessage("Tlačítky i naklopením"),
    "game_control_screen_tilt" : MessageLookupByLibrary.simpleMessage("Naklopením telefonu"),
    "help_advanced_game_par_1" : MessageLookupByLibrary.simpleMessage("I když k tomu aplikace zatím nevybízí a není k tomu optimalizovaná při výběru otázek, je možné hádat i předvedením (pantomimou) nebo nakreslením."),
    "help_advanced_game_title" : MessageLookupByLibrary.simpleMessage("Hry pro pokročilé"),
    "help_game_control_blind_par_1" : MessageLookupByLibrary.simpleMessage("Jeden z hráčů hádá termín a nevidí jej, ostatní jej vidí a snaží se jej popsat. Zda byla odpověď správná či špatná lze označit naklopením telefonu."),
    "help_game_control_blind_title" : MessageLookupByLibrary.simpleMessage("Slepec"),
    "help_game_control_narrator_par_1" : MessageLookupByLibrary.simpleMessage("Jeden z hráčů vidí hádaný termín a popisuje jej, ostatní jej nevidí a hádají. Odpověď lze označit tlačítky."),
    "help_game_control_narrator_title" : MessageLookupByLibrary.simpleMessage("Vypravěč"),
    "help_game_control_score_par_1" : MessageLookupByLibrary.simpleMessage("V nastaveních zvolte neomezenou délku hry. Hra trvá dokud nedojdou termíny. Kdo má nejvíce uhodnuto?"),
    "help_game_control_score_title" : MessageLookupByLibrary.simpleMessage("Nejvyšší skóre"),
    "help_game_control_time_par_1" : MessageLookupByLibrary.simpleMessage("V nastaveních zvolte délku hry. Kdo stihne nejvíce odpovědí v časovém limitu?"),
    "help_game_control_time_title" : MessageLookupByLibrary.simpleMessage("Na čas"),
    "help_game_control_title" : MessageLookupByLibrary.simpleMessage("Herní styly"),
    "help_how_to_play_buttons_par_1" : MessageLookupByLibrary.simpleMessage("Na obrazovce s hádaným termínem jsou zobrazena tlačítka pro správnou a špatnou odpověď."),
    "help_how_to_play_par_1" : MessageLookupByLibrary.simpleMessage("Hra je určena pro 2 a více hráčů. V případě více hráčů je možné se rozdělit do několik týmů o minimálně dvou hráčích. Principem hry je uhodnout co nejvíce zobrazených termínů. V průběhu se nesmí používat slova se stejným kořenem, jako hádaný termín. Hráč může hádat dokud neodpoví správně. Pokud je však hra limitovaná časem nebo je termín příliš těžký, je možné jej přeskočit."),
    "help_how_to_play_par_2" : MessageLookupByLibrary.simpleMessage("Způsob odpovídání na otázky lze změnit v nastaveních."),
    "help_how_to_play_tilt_par_1" : MessageLookupByLibrary.simpleMessage("Telefon je nutné mít přitisknutý na čele. Správná odpověď se zvolí naklopením displeje dolu, špatná naklopením nahoru."),
    "help_how_to_play_title" : MessageLookupByLibrary.simpleMessage("Jak hrát"),
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
    "settings_language" : MessageLookupByLibrary.simpleMessage("Jazyk"),
    "settings_language_description" : MessageLookupByLibrary.simpleMessage("Ovlivňuje rozhraní aplikace, témata a otázky. Vyžaduje restart."),
    "settings_title_interface" : MessageLookupByLibrary.simpleMessage("Rozhraní"),
    "settings_title_languages" : MessageLookupByLibrary.simpleMessage("Jazyky"),
    "settings_title_options" : MessageLookupByLibrary.simpleMessage("Nastavení hry"),
    "start_game_button" : MessageLookupByLibrary.simpleMessage("Start hry"),
    "start_game_prompt" : MessageLookupByLibrary.simpleMessage("Jste připraveni ke hře?")
  };
}
