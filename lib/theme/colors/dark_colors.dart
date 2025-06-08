part of '../theme.dart';

class DarkColors extends AppColors {
  @override
  Color get primaryColor => ConstantColors.primary600;
  @override
  Color get lightPrimaryColor => ConstantColors.primary700;

  // Text
  @override
  Color get textPrimary => ConstantColors.slate50;
  @override
  Color get textSecondary => ConstantColors.primary500;

  // Error
  @override
  Color get errorPrimary => ConstantColors.danger600;
  @override
  Color get errorSecondary => ConstantColors.danger800;

  // Surfaces
  @override
  Color get surfacePrimary => ConstantColors.slate700;
  @override
  Color get surfaceSecondary => ConstantColors.slate600;

  @override
  Color get shimmerHighlight => ConstantColors.slate500;
  @override
  Color get shimmerBase => ConstantColors.slate600;

  // Borders
  @override
  Color get borderPrimary => ConstantColors.slate400;
  @override
  Color get borderFocused => ConstantColors.slate400;
  @override
  Color get dividerColor => ConstantColors.slate500;

  // Loaders
  @override
  Color get loader => ConstantColors.slate500;
  @override
  Color get loaderBackground => ConstantColors.slate600;
}
