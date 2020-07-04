# Act, Draw, Explain

[![Translation status](https://weblate.lat.sk/widgets/act-draw-explain/-/svg-badge.svg)](https://weblate.lat.sk/engage/act-draw-explain/?utm_source=widget)

A multi-player game based on popular games, such as Charades, Heads-up and Pictionary.

# How to contribute

This is an open source project and everyone is welcome to contribute to the game. Here are several options how you can contribute today:

1. [Report bugs](https://github.com/radeklat/act-draw-explain/issues/new/choose)
2. [Suggest new features](https://github.com/radeklat/act-draw-explain/issues/new/choose)
3. Create new topics, add more questions into existing topics or fix typos (see [Game data](#game-data) below)
4. Translate the app into more languages (see [Translating via translation system](#translating-via-translation-system) below)
5. Improve the code base via Pull requests

You don't have to be a Flutter developer to contribute. Files are editable in GitHub directly and translations are handled by a translation system. Easier task, such as fixing a typo, are a matter of a few click.

## Development

This project is written in Flutter and at the moment being built and distributed only on Android. However, the language was chosen with long term intention to distribute the project to other platforms as well.

The development language is English to make this project as widely available as possible to the development community. This includes commit messages, change logs, development documentation and code comments.

### Languages

Current support:

[![Translation status](https://weblate.lat.sk/widgets/act-draw-explain/-/multi-auto.svg)](https://weblate.lat.sk/engage/act-draw-explain/?utm_source=widget)

The application UI can be translated to any number of languages. The game data is at the moment static, mostly Czech, with some packages in English. Integration with the translation system is planned in the near future.

#### Translating via translation system

1. Register to [Weblate](https://weblate.lat.sk/engage/act-draw-explain/) for the Act, Draw, Explain app.
2. Translate the UI in the [Flutter app component](https://weblate.lat.sk/projects/act-draw-explain/flutter-app/).

#### Translation support in code

The application utilizes [`intl`](https://pub.dev/packages/intl) and [`intl_utils`](https://pub.dev/packages/intl_utils) packages.

Application translations are kept in [ARB files](https://github.com/google/app-resource-bundle/wiki/ApplicationResourceBundleSpecification). See [Plural](https://support.crowdin.com/icu-message-syntax/#plural) and [gender](https://support.crowdin.com/icu-message-syntax/#select) formatting in translations.

Locale is in form of `<LANGUAGE CODE>` or `<LANGUAGE CODE>_<COUNTRY CODE>`, where:
* `<LANGUAGE CODE>` is [ISO 639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) language code
* `<COUNTRY CODE>` is [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements) country code. This code is optional.

##### Adding new string

1. Add it to `lib/I10n/intl_en.arb` (this is the base language)
2. Run `flutter pub run intl_utils:generate` to generate boilerplate code
3. Use the boilerplate in the codebase as `S.of(context).NAME` where `NAME` is name of the string.

#### Adding new language

1. Start new translations in [Weblate](https://weblate.lat.sk/projects/act-draw-explain/) for all components.
2. Translate strings in all components.

### Game data

Topic and questions are at the moment distributed with the app. They are located in `lib/data`.

### Testing

Since testing tools for Flutter are still in their infancy, the tooling is often broken, too simple or non-existent. To see test coverage, the project utilizes codecov.io for visualisation.

Unit tests are located in `test/unit`, widget tests in `test/widget`. Rudimentary application tests are located in `test_driver`. However, as they are not stable and too simplistic, they are not used to verify correct app behaviour.

To generate a combined test/widget tests coverage report, run:

```bash
flutter test --coverage && bash <(curl -s https://codecov.io/bash) -f coverage/lcov.info
```