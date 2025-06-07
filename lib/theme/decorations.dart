part of 'theme.dart';

class Decorations {
  ///----------------------------
  /// INPUTS
  ///----------------------------
  static InputDecoration inputDecoration({
    required bool isCupertino,
    required InputType type,
    required String errorMessage,
    required Color errorColor,
    required double suffixPadding,
    required double prefixPadding,
    required bool fill,
    required Color fillColor,
    required Color errorBorderColor,
    required Color borderColor,
    required Color focusedBorderColor,
    required Color disabledBorderColor,
    required Color errorFocusedBorderColor,
    required bool roundedCorners,
    bool hasLeadingIcon = false,
    bool hasError = false,
    bool filled = true,
  }) {
    double left = Sizes.inputPadding, right = Sizes.inputPadding;

    return InputDecoration(
      floatingLabelBehavior: isCupertino
          ? FloatingLabelBehavior.never
          : FloatingLabelBehavior.auto,
      contentPadding: EdgeInsets.only(
        left: left + prefixPadding,
        right: right + suffixPadding,
        bottom: 8,
        top: 8,
      ),
      filled: fill,
      fillColor: fillColor,
      errorStyle: FontStyles.style(size: FontSize.label, textColor: errorColor),
      errorText: errorMessage.isNotEmpty ? errorMessage : null,
      errorBorder: inputBorder(errorBorderColor, roundedCorners),
      focusedBorder: inputBorder(focusedBorderColor, roundedCorners),
      enabledBorder: inputBorder(borderColor, roundedCorners),
      disabledBorder: inputBorder(disabledBorderColor, roundedCorners),
      focusedErrorBorder: inputBorder(errorFocusedBorderColor, roundedCorners),
      errorMaxLines: 2,
    );
  }

  ///----------------------------
  /// BORDERS
  ///----------------------------

  static InputBorder inputBorder(Color borderColor, bool roundedCorners) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(roundedCorners
            ? Sizes.roundedInputBorderRadius
            : Sizes.inputBorderRadius),
      ),
      borderSide: BorderSide(
        color: borderColor,
      ),
    );
  }

  ///----------------------------
  /// BOX SHADOWS
  ///----------------------------
  static BoxShadow toastHardShadow = BoxShadow(
    color: ConstantColors.black.withValues(alpha: .3),
    offset: const Offset(0, 1),
    blurRadius: 3,
    spreadRadius: 0,
  );

  static BoxShadow toastSoftShadow = BoxShadow(
    color: ConstantColors.black.withValues(alpha: .1),
    offset: const Offset(0, 4),
    blurRadius: 8,
    spreadRadius: 3,
  );

  static BoxShadow tagShadow(Color color) => BoxShadow(
        color: color.withValues(alpha: .2),
        offset: const Offset(0, 4),
        blurRadius: 20,
        spreadRadius: 0,
      );

  static BoxShadow regularCardShadow = BoxShadow(
    color: ConstantColors.black.withValues(alpha: .2),
    offset: const Offset(0, 4),
    blurRadius: 20,
    spreadRadius: 0,
  );

  static BoxShadow softCardShadow = BoxShadow(
    color: ConstantColors.black.withValues(alpha: .1),
    offset: const Offset(0, 4),
    blurRadius: 20,
    spreadRadius: 0,
  );
}
