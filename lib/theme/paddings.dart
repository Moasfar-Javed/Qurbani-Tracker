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

  static EdgeInsets horizontalCardInsets(
    BuildContext context, {
    double top = 0,
    double bottom = 0,
    bool left = true,
    bool right = true,
  }) {
    EdgeInsets padding = MediaQuery.of(context).padding;

    return EdgeInsets.fromLTRB(
      left ? max(padding.right, Sizes.horizontalCardPadding) : 0,
      top,
      right ? max(padding.right, Sizes.horizontalCardPadding) : 0,
      bottom,
    );
  }

  static EdgeInsets groupedMenuInsets(
    BuildContext context,
  ) {
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
