part of 'theme.dart';

class AppThemes {
  static final DarkColors _darkColors = DarkColors();

  static final CupertinoThemeData darkTheme = _generateTheme(
    _darkColors,
    Brightness.dark,
  );

  static CupertinoThemeData _generateTheme(
    AppColors colors,
    Brightness brightness,
  ) {
    return CupertinoThemeData(
      brightness: brightness,
      primaryColor: colors.primaryColor,
      primaryContrastingColor: colors.lightPrimaryColor,
      scaffoldBackgroundColor: colors.surfacePrimary,
      barBackgroundColor: colors.surfacePrimary,
      applyThemeToAll: true,
      textTheme: CupertinoTextThemeData(
        textStyle: FontStyles.style(
          size: FontSize.bodyLarge,
          textColor: colors.textPrimary,
        ),
        navTitleTextStyle: FontStyles.style(
          size: FontSize.titleBold,
          textColor: colors.textPrimary,
        ),
        pickerTextStyle: FontStyles.style(
          size: FontSize.body,
          textColor: colors.textPrimary,
        ),
      ),
    );
  }
}
