import 'dart:ui';

Locale localeFromString(String locale) {
  List<String> languageCountry = locale.split("_");
  return (languageCountry.length == 1) ? Locale(languageCountry[0]) : Locale(languageCountry[0], languageCountry[1]);
}

bool localeLanguageCodeIn(Locale locale, List<Locale> locales) {
  for (int i = 0; i < locales.length; i++) {
    if (locale.languageCode == locales[i].languageCode) return true;
  }

  return false;
}