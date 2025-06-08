part of 'theme.dart';

class Paddings {
  static EdgeInsets horizontalScreenInsets(
    BuildContext context, {
    double top = 0,
    double bottom = 0,
    bool left = true,
    bool right = true,
  }) {
    EdgeInsets padding = MediaQuery.of(context).padding;

    return EdgeInsets.only(
      left: left ? max(padding.right, Sizes.horizontalPadding) : 0,
      top: top,
      right: right ? max(padding.right, Sizes.horizontalPadding) : 0,
      bottom: bottom,
    );
  }

  static EdgeInsets cardInsets(BuildContext context) {
    return EdgeInsets.fromLTRB(
      Sizes.horizontalCardPadding,
      Sizes.spacingM,
      Sizes.horizontalCardPadding,
      Sizes.spacingM,
    );
  }

  static EdgeInsets groupedMenuInsets(BuildContext context) {
    return EdgeInsets.fromLTRB(
      Sizes.spacingL,
      Sizes.spacingXS,
      Sizes.spacingL,
      Sizes.spacingXS,
    );
  }

  static EdgeInsets dialogInsets(BuildContext context) {
    return EdgeInsets.all(Sizes.spacingXL);
  }
}
