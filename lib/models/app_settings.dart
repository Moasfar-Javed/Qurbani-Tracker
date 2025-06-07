part of 'models.dart';

class AppSettings {
  AppTheme theme;
  String locale;
  bool isUserOnboarded;
  bool isUserLoggedIn;

  AppSettings({
    required this.theme,
    required this.locale,
    required this.isUserOnboarded,
    required this.isUserLoggedIn,
  });

  static AppSettings get defaultSettings => AppSettings(
    theme: AppTheme.dark,
    locale: Languages.defaultLocale,
    isUserOnboarded: false,
    isUserLoggedIn: false,
  );

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      theme: AppTheme.values[json['theme']],
      locale: json['locale'] ?? Languages.defaultLocale,
      isUserOnboarded: json["isUserOnboarded"] == 1,
      isUserLoggedIn: json["isUserLoggedIn"] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'theme': theme.index,
      'locale': locale,
      'isUserOnboarded': isUserOnboarded.toInt(),
      'isUserLoggedIn': isUserLoggedIn.toInt(),
    };
  }
}
