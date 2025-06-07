part of 'constants.dart';

class Languages {
  static const List<Locale> supported = [fallback];

  static const String pathToFiles = 'assets/translations';

  static const String defaultLocale = 'en';

  static const Locale fallback = Locale(defaultLocale);

  static const Map<String, String> languageLocaleMap = {"English": "en"};

  static String languageToLocale(String language) {
    return languageLocaleMap[language] ?? (throw UnimplementedError());
  }

  static String localeToLanguage(String locale) {
    return languageLocaleMap.entries
        .firstWhere(
          (entry) => entry.value == locale,
          orElse: () => throw UnimplementedError(),
        )
        .key;
  }
}
