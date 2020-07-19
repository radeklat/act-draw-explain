# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).
Types of changes are:

* **Breaking changes** for breaking changes.
* **Features** for new features or changes in existing functionality.
* **Fixes** for any bug fixes.

## [Unreleased]
<!-- Don't forget to update version in pubspec.yaml -->

## [2.0.0+17] - 2020-07-19 <a name="2.0.0" />
### Features
* Translate application to English
* Allow choosing language for the app UI and game data
* Translate some topics into English
* App UI and Game data can be translated in a [translation system](https://weblate.lat.sk)
* Custom crash screen

### BREAKING CHANGES
* Topics that have no translations in selected language are hidden
* Topics disabled for selected language are hidden

## [1.1.1+15] - 2020-07-11 <a name="1.1.1" />
### Fixes
* Crash when system language was not available among translations. Now the app UI will default to English.

## [1.1.0+13] - 2020-06-20 <a name="1.1.0" />
### Features
* Adds UI translation to English

### Fixes
* Typos

## [1.0.0+11] - 2020-06-20 <a name="1.0.0" />
### Features
* Adds attributions screen

### BREAKING CHANGES
* Change log link moved into "About app" screen

## [0.7.0+10] - 2020-05-31 <a name="0.7.0" />
### Features
* New topics "Occupations", "Assigned reading", "Musical instruments", "Best selling singles" and "Czech companies"

### Fixes
* Typos
* Duplicate questions removed

## [0.6.0+9] - 2020-05-24 <a name="0.6.0" />
### Features
* New topics "Videogames" and "Food and drinks"
* Adds new questions into "RuPaul's Drag Race"

## [0.5.0+8] - 2020-05-17 <a name="0.5.0" />
### Features
* New topic "hobbies"

### Fixes
* Remove unnecessary and PID information from bug report
* GameScore counting guessed questions count wrong on timeout

## [0.4.0+7] - 2020-05-13 <a name="0.4.0" />
### Features
* Link to feedback (bug report, feature requests) from the app
* Link to change log from the app

### Fixes
* Font od body text from bold to normal

## [0.3.0+6] - 2020-05-10 <a name="0.3.0" />
### Features
* Analytics

### Fixes
* Wrong score when the last question was a pass

## [0.2.1+5] - 2020-05-09 <a name="0.2.1" />
### Features
*  Downgraded Flutter from v0.17.0 causing app to crash on start to previous v1.16.3

## [0.2.0+4] - 2020-05-09 <a name="0.2.0" />
### Features
* App name localisation to CS/EN in app launcher
* Update application icon

### Fixes
* Overflowing cards with topic
* App crashing when max questions higher than available questions count.
* Missing advanced game play documentation

## [0.1.2+3] - 2020-05-08 <a name="0.1.2" />

### Features
* Basic analytics
### Fixes
* Crashing countdown screen causing it to be stuck on the initial value.

## [0.1.1+2] - 2020-05-08 <a name="0.1.1" />

### Features
* Crashlytics

## [0.1.0+1] - 2020-04-08 <a name="0.1.0" />

### Features
* Initial source code

[Unreleased]: https://github.com/radeklat/act-draw-explain/compare/releases/2.0.0+17...HEAD
[2.0.0+17]: https://github.com/radeklat/act-draw-explain/compare/releases/1.1.1+15...releases/2.0.0+17
[1.1.1+15]: https://github.com/radeklat/act-draw-explain/compare/releases/1.1.0+13...releases/1.1.1+15
[1.1.0+13]: https://github.com/radeklat/act-draw-explain/compare/releases/1.0.0+11...releases/1.1.0+13
[1.0.0+11]: https://github.com/radeklat/act-draw-explain/compare/releases/0.7.0+10...releases/1.0.0+11
[0.7.0+10]: https://github.com/radeklat/act-draw-explain/compare/releases/0.6.0+9...releases/0.7.0+10
[0.6.0+9]: https://github.com/radeklat/act-draw-explain/compare/releases/0.5.0+8...releases/0.6.0+9
[0.5.0+8]: https://github.com/radeklat/act-draw-explain/compare/releases/0.4.0+7...releases/0.5.0+8
[0.4.0+7]: https://github.com/radeklat/act-draw-explain/compare/releases/0.3.0+6...releases/0.4.0+7
[0.3.0+6]: https://github.com/radeklat/act-draw-explain/compare/releases/0.2.1+5...releases/0.3.0+6
[0.2.1+5]: https://github.com/radeklat/act-draw-explain/compare/releases/0.2.0+4...releases/0.2.1+5
[0.2.0+4]: https://github.com/radeklat/act-draw-explain/compare/releases/0.1.2+3...releases/0.2.0+4
[0.1.2+3]: https://github.com/radeklat/act-draw-explain/compare/releases/0.1.1+2...releases/0.1.2+3
[0.1.1+2]: https://github.com/radeklat/act-draw-explain/compare/releases/0.1.0+1...releases/0.1.1+2
[0.1.0+1]: https://github.com/radeklat/act-draw-explain/compare/initial...releases/0.1.0+1