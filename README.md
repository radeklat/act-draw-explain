# Act, Draw, Explain

A multi-player game based on popular games, such as Charades, Heads-up and Pictionary.

# How to contribute

This is an open source project and everyone is welcome to contribute to the game. Here are several options how you can contribute today:

1. [Report bugs](https://github.com/radeklat/act-draw-explain/issues/new/choose)
2. [Suggest new features](https://github.com/radeklat/act-draw-explain/issues/new/choose)
3. Create new topics (see [Game data](#game-data) below)
4. Add more questions into existing topics
5. Fix typos
6. Improve the code base via Pull requests

You don't have to be a Flutter developer to contribute. Files are editable in GitHub directly. So easier things like fixing a typo are a matter of a few click.

## Development

This project is written in Flutter and at the moment being built and distributed only on Android. However, the language was chosen with long term intention to distribute the project to other platforms as well.

### Languages

The ultimate goal of the app is to be multi-lingual. As a Czech/English bilingual author, it was easier for me to start with Czech interface and game data. The near future intention to be multi-lingual with initial support of Czech and English.

The game data is mostly Czech, with some packages in English.

The development language is English to make this project as available as possible to the development community. This includes commit messages, change log, development documentation and code comments.

### Game data

Topic and questions are at the moment distributed with the app. They are located in `lib/data`.

### Testing

Since testing tools for Flutter are still in their infancy, the tooling is often broken, too simple or non-existent. To see test coverage, the project utilizes codecov.io for visualisation.

Unit tests are located in `test/unit`, widget tests in `test/widget`. Rudimentary application tests are located in `test_driver`. However, as they are not stable and too simplistic, they are not used to verify correct app behaviour.

To generate a combined test/widget tests coverage report, run:

```bash
flutter test --coverage && bash <(curl -s https://codecov.io/bash) -f coverage/lcov.info
```