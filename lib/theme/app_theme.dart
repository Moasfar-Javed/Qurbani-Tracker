part of 'theme.dart';

class AppThemes {
  static final DarkColors _darkColors = DarkColors();

  static final ThemeData lightTheme = _generateTheme(
    _darkColors,
    Brightness.light,
  );

  static ThemeData _generateTheme(AppColors colors, Brightness brightness) {
    return ThemeData(
      brightness: brightness,
      primaryColor: colors.primaryColor,
      iconTheme: IconThemeData(color: colors.primaryColor),
      hoverColor: colors.lightPrimaryColor,
      dividerColor: colors.dividerColor,
      fontFamily: "Nunito",
      useMaterial3: true,
      colorScheme: ColorScheme(
        primary: colors.primaryColor,
        secondary: colors.primaryColor,
        surface: colors.surfacePrimary,
        error: colors.errorPrimary,
        onPrimary: colors.onPrimary,
        onSecondary: colors.textPrimary,
        onSurface: colors.textPrimary,
        onError: colors.textPrimary,
        brightness: brightness,
      ),
      textTheme: TextTheme(bodyMedium: TextStyle(fontSize: Sizes.fontSizeL)),
      appBarTheme: AppBarTheme(
        surfaceTintColor: colors.primaryColor.withValues(alpha: .8),
        scrolledUnderElevation: 5,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.inputCursor,
        selectionColor: colors.lightPrimaryColor,
        selectionHandleColor: colors.primaryColor,
      ),
      scaffoldBackgroundColor: colors.surfacePrimary,
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.cardBorderRadiusM),
        ),
        checkColor: WidgetStatePropertyAll(Colors.white),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primaryColor;
          }
          return Colors.transparent;
        }),
        side: BorderSide(color: colors.borderPrimary),
      ),
      tabBarTheme: TabBarThemeData(indicatorColor: colors.primaryColor),
    );
  }
}
