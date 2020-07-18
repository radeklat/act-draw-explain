<h1 align="center" style="border-bottom: none;">:ok_person::crayon::speech_balloon:&nbsp;&nbsp; Act, Draw, Explain &nbsp;&nbsp;:speech_balloon::crayon::ok_person:</h1>
<h3 align="center">A multi-player game based on popular games, such as Charades, Heads-up and Pictionary</h3>

<p align="center">
    <img alt="License" src="https://img.shields.io/github/license/radeklat/act-draw-explain">
    <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/radeklat/act-draw-explain">
    <img alt="App version" src="https://img.shields.io/badge/dynamic/yaml?color=informational&label=version&query=version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fradeklat%2Fact-draw-explain%2Fmaster%2Fpubspec.yaml">
    <a href="https://codecov.io/gh/radeklat/act-draw-explain">
        <img alt="codecov" src="https://codecov.io/gh/radeklat/act-draw-explain/branch/master/graph/badge.svg">
    </a>
    <a href="https://weblate.lat.sk/engage/act-draw-explain/?utm_source=github">
        <img alt="Translation status" src="https://weblate.lat.sk/widgets/act-draw-explain/-/svg-badge.svg">
    </a>
</p>

# How to contribute

This is an open source project and everyone is welcome to contribute to the game. Here are several options how you can contribute today:

1. [Report bugs](https://github.com/radeklat/act-draw-explain/issues/new/choose)
2. [Suggest new features](https://github.com/radeklat/act-draw-explain/issues/new/choose)
3. Create new topics, add more questions into existing topics or fix typos (see [Game data](#game-data) below)
4. Translate the app into more languages (see [Guide for translators](#guide-for-translators) below)
5. Improve the code base via Pull requests

You don't have to be a Flutter developer to contribute. Files are editable in GitHub directly and translations are handled by a translation system. Easier task, such as fixing a typo, are a matter of a few click.

# Guide for translators

1. Register to [Weblate](https://weblate.lat.sk/engage/act-draw-explain/) for the Act, Draw, Explain app.
2. Translate one of the following components:
   * [User interface](https://weblate.lat.sk/projects/act-draw-explain/flutter-app/) (menus, help, etc.)
   * [Game topics](https://weblate.lat.sk/projects/act-draw-explain/game-topics/)
   * [Game questions](https://weblate.lat.sk/projects/act-draw-explain/game-questions/)

Overall language support:

[![Translation status](https://weblate.lat.sk/widgets/act-draw-explain/-/multi-auto.svg)](https://weblate.lat.sk/engage/act-draw-explain/?utm_source=widget)

## Disabling translations

Not all questions or topics make sense to translate. Some may be culturally specific or have no equivalent in the target language. To disable a question or a topic, use `DISABLED` as the translation string. It will be then hidden by the app.

## Adding new language

1. Start new translations in [Weblate](https://weblate.lat.sk/projects/act-draw-explain/) for all components.
2. Translate strings in all components.

## Plurals and genders

Some strings may allow specifying variants for different plurals or genders. Unfortunately, the translation system renders these in their original syntax. See [Plural](https://support.crowdin.com/icu-message-syntax/#plural) and [gender](https://support.crowdin.com/icu-message-syntax/#select) for a reference.

# Development

This project is written in Flutter and at the moment being built and distributed only on Android. However, the language was chosen with long term intention to distribute the project to other platforms as well.

The development language is English to make this project as widely available as possible to the development community. This includes commit messages, change logs, development documentation and code comments.

## Translation support in code

The application utilizes [`intl`](https://pub.dev/packages/intl) and [`intl_utils`](https://pub.dev/packages/intl_utils) packages.

Application translations are kept in [ARB files](https://github.com/google/app-resource-bundle/wiki/ApplicationResourceBundleSpecification). See also [Plurals and genders](#plurals-and-genders).

Locale is in form of `<LANGUAGE CODE>` or `<LANGUAGE CODE>_<COUNTRY CODE>`, where:
* `<LANGUAGE CODE>` is [ISO 639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) language code
* `<COUNTRY CODE>` is [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements) country code. This code is optional.

### Adding new UI strings

1. Add the string into `lib/I10n/intl_en.arb` (this is the base language). See also  [Plurals and genders](#plurals-and-genders).
2. Run `flutter pub run intl_utils:generate` to generate boilerplate code
3. Use the boilerplate in the codebase as `S.of(context).NAME` where `NAME` is name of the string.
4. Translate the string to other languages.

## Game data

Topic and questions are at the moment distributed with the app. They are located in `assets/data`. The `topics.xliff` and `questions.xliff` are reference files that must contain all available strings in any language (`en`, if possible). They contain additional metadata used only by the app and ignored by the translation system.

Running `flutter pub run sync_translation_files` from the repository source will:
* inject `DISABLED` into all question of a disabled topic in given language variant (see [Disabling translations](#disabling-translations) below)
* inject topic names into questions to be visible as context in the translation system

## Testing

Since testing tools for Flutter are still in their infancy, the tooling is often broken, too simple or non-existent. To see test coverage, the project utilizes codecov.io for visualisation.

Unit tests are located in `test/unit`, widget tests in `test/widget`. Rudimentary application tests are located in `test_driver`. However, as they are not stable and too simplistic, they are not used to verify correct app behaviour.

To generate a combined test/widget tests coverage report, run:

```bash
flutter test --coverage && bash <(curl -s https://codecov.io/bash) -f coverage/lcov.info
```

