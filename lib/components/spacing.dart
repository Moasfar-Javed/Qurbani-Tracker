part of './components.dart';

class Spacing extends StatelessWidget {
  final SpacingSize size;

  const Spacing({
    this.size = SpacingSize.medium,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedSize = _getSize();
    return SizedBox(
      height: resolvedSize,
      width: resolvedSize,
    );
  }

  double _getSize() {
    switch (size) {
      case SpacingSize.form:
        return Sizes.spacingForms;
      case SpacingSize.pageBottomBarBottom:
        return Sizes.spacingXXL * 3;
      case SpacingSize.pageTopBottom:
        return Sizes.spacingPageTopBottom;
      case SpacingSize.xSmall:
        return Sizes.spacingXS;
      case SpacingSize.small:
        return Sizes.spacingS;
      case SpacingSize.medium:
        return Sizes.spacingM;
      case SpacingSize.large:
        return Sizes.spacingL;
      case SpacingSize.xLarge:
        return Sizes.spacingXL;
      case SpacingSize.xxLarge:
        return Sizes.spacingXXL;
    }
  }
}
