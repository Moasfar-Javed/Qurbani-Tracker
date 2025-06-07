part of 'theme.dart';

class Shadows {
  static List<BoxShadow> style({Shadow style = Shadow.medium}) {
    switch (style) {
      case Shadow.xSmall:
        return _getXSmallShadow();
      case Shadow.small:
        return _getSmallShadow();
      case Shadow.medium:
        return _getMediumShadow();
      case Shadow.large:
        return _getLargeShadow();
      case Shadow.xLarge:
        return _getXLargeShadow();
      case Shadow.xxLarge:
        return _getXXLargeShadow();
    }
  }

  static List<BoxShadow> _getXSmallShadow() {
    return [
      BoxShadow(
        blurRadius: 2,
        offset: const Offset(0, 1),
        spreadRadius: 0,
        color: ConstantColors.slate800.withValues(alpha: 0.05),
      ),
    ];
  }

  static List<BoxShadow> _getSmallShadow() {
    return [
      BoxShadow(
        blurRadius: 3,
        offset: const Offset(0, 1),
        spreadRadius: 0,
        color: ConstantColors.slate800.withValues(alpha: 0.10),
      ),
      BoxShadow(
        blurRadius: 2,
        offset: const Offset(0, 1),
        spreadRadius: 0,
        color: ConstantColors.slate800.withValues(alpha: 0.05),
      ),
    ];
  }

  static List<BoxShadow> _getMediumShadow() {
    return [
      BoxShadow(
        blurRadius: 8,
        offset: const Offset(0, 4),
        spreadRadius: -2,
        color: ConstantColors.slate800.withValues(alpha: 0.10),
      ),
      BoxShadow(
        blurRadius: 4,
        offset: const Offset(0, 2),
        spreadRadius: -2,
        color: ConstantColors.slate800.withValues(alpha: 0.06),
      ),
    ];
  }

  static List<BoxShadow> _getLargeShadow() {
    return [
      BoxShadow(
        blurRadius: 16,
        offset: const Offset(0, 12),
        spreadRadius: -4,
        color: ConstantColors.slate800.withValues(alpha: 0.10),
      ),
      BoxShadow(
        blurRadius: 6,
        offset: const Offset(0, 4),
        spreadRadius: -2,
        color: ConstantColors.slate800.withValues(alpha: 0.05),
      ),
    ];
  }

  static List<BoxShadow> _getXLargeShadow() {
    return [
      BoxShadow(
        blurRadius: 24,
        offset: const Offset(0, 20),
        spreadRadius: -4,
        color: ConstantColors.slate800.withValues(alpha: 0.10),
      ),
      BoxShadow(
        blurRadius: 8,
        offset: const Offset(0, 8),
        spreadRadius: -4,
        color: ConstantColors.slate800.withValues(alpha: 0.04),
      ),
    ];
  }

  static List<BoxShadow> _getXXLargeShadow() {
    return [
      BoxShadow(
        blurRadius: 48,
        offset: const Offset(0, 24),
        spreadRadius: -12,
        color: ConstantColors.slate800.withValues(alpha: 0.25),
      ),
    ];
  }
}
