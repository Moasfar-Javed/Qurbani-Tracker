part of 'theme.dart';

class FontStyles {

  static TextDirection getTextDirection() => TextDirection.ltr;

  static TextStyle style({FontSize size = FontSize.body, Color? textColor}) {
    var sizes = _getFontSize(size);
    return TextStyle(
      fontSize: sizes.$1,
      fontWeight: sizes.$2,
      color: textColor,
    );
  }

  static (double, FontWeight) _getFontSize(FontSize size) {
    switch (size) {
      case FontSize.title:
        return (Sizes.fontSizeXXL, FontWeight.w500);
      case FontSize.titleBold:
        return (Sizes.fontSizeXXL, FontWeight.w700);
      case FontSize.titleBlack:
        return (Sizes.fontSizeXXL, FontWeight.w800);
      case FontSize.heading:
        return (Sizes.fontSizeXL, FontWeight.w500);
      case FontSize.headingBold:
        return (Sizes.fontSizeXL, FontWeight.w600);
      case FontSize.headingBlack:
        return (Sizes.fontSizeXL, FontWeight.w700);
      case FontSize.bodyLarge:
        return (Sizes.fontSizeL, FontWeight.w500);
      case FontSize.bodyLargeBold:
        return (Sizes.fontSizeL, FontWeight.w600);
      case FontSize.bodyLargeBlack:
        return (Sizes.fontSizeL, FontWeight.w700);
      case FontSize.body:
        return (Sizes.fontSizeM, FontWeight.w500);
      case FontSize.bodyBold:
        return (Sizes.fontSizeM, FontWeight.w600);
      case FontSize.bodyBlack:
        return (Sizes.fontSizeM, FontWeight.w700);
      case FontSize.label:
        return (Sizes.fontSizeS, FontWeight.w500);
      case FontSize.labelBold:
        return (Sizes.fontSizeS, FontWeight.w600);
    }
  }
}
