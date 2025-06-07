part of '../theme.dart';

abstract class AppColors {
  Color get primaryColor;
  Color get lightPrimaryColor;
  Color get onPrimary => ConstantColors.white;

  // Text
  Color get textPrimary;
  Color get textSecondary;
  Color get textError => errorPrimary;

  // Error
  Color get errorPrimary;
  Color get errorSecondary;

  // Surfaces
  Color get surfacePrimary;
  Color get surfaceSecondary;

  // Loaders
  Color get shimmerHighlight;
  Color get shimmerBase;
  Color get loader;
  Color get loaderBackground;

  // Borders
  Color get borderPrimary;
  Color get borderFocused;
  Color get errorBorder => errorSecondary;

  // Inputs
  Color get inputFocusColor => primaryColor;
  Color get inputTextDisabled => textPrimary;
  Color get inputTextError => textError;
  Color get inputCursor => primaryColor;
  Color get inputErrorCursor => errorSecondary;
  Color get inputBackground => surfacePrimary;
  Color get inputDisabledBackground => surfacePrimary;
  Color get inputBorder => borderPrimary;
  Color get inputBorderFocused => borderFocused;
  Color get inputBorderError => errorBorder;
  Color get inputBorderDisabled => borderPrimary;

  // Buttons
  Color get primaryButton => primaryColor;
  Color get primaryButtonText => onPrimary;
  Color get primaryButtonBorder => primaryButton;
  Color get primaryButtonLoader => primaryButtonText;

  Color get dangerButton => errorPrimary;
  Color get dangerButtonText => onPrimary;
  Color get dangerButtonBorder => dangerButton;
  Color get dangerButtonLoader => onPrimary;

  Color get textButton => Colors.transparent;
  Color get textButtonText => textSecondary;
  Color get textButtonBorder => Colors.transparent;
  Color get textButtonLoader => textPrimary;

  // Dividers
  Color get dividerColor;
}
