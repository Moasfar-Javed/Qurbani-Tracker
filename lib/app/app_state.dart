part of 'app_cubit.dart';

sealed class AppState extends Equatable {
  const AppState(this.theme, this.colors, this.themeData, this.locale);

  final AppTheme theme;
  final AppColors colors;
  final ThemeData themeData;
  final String locale;
}

final class AppInitial extends AppState {
  const AppInitial(super.theme, super.colors, super.themeData, super.locale);

  @override
  List<Object?> get props => [theme, colors, themeData, locale];
}

final class AppLoaded extends AppState {
  const AppLoaded(
    super.theme,
    super.colors,
    super.themeData,
    super.locale, {
    required this.appSettings,
  });

  final AppSettings appSettings;

  @override
  List<Object?> get props => [theme, colors, themeData, locale, appSettings];
}

final class AppReady extends AppState {
  const AppReady(
    super.theme,
    super.colors,
    super.themeData,
    super.locale, {
    required this.appSettings,
    required this.nextRoute,
  });

  final AppSettings appSettings;
  final String? nextRoute;

  @override
  List<Object?> get props => [
    theme,
    colors,
    themeData,
    locale,
    appSettings,
    nextRoute,
  ];
}
