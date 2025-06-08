part of '../components.dart';

class Skeleton {
  static Widget circle({required double radius, margin = EdgeInsets.zero}) =>
      SkeletonCircle(radius: radius, margin: margin);

  static Widget rect({
    required double width,
    required double height,
    margin = EdgeInsets.zero,
  }) => SkeletonRect(width: width, height: height, margin: margin);

  static Widget text({margin = EdgeInsets.zero}) =>
      SkeletonRect(width: 100, height: 20, margin: margin);
}

class SkeletonRect extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;

  const SkeletonRect({
    super.key,
    required this.width,
    required this.height,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return Shimmer.fromColors(
          baseColor: appState.colors.shimmerBase,
          highlightColor: appState.colors.shimmerHighlight,
          child: Container(
            height: height,
            margin: margin,
            width: width,
            decoration: BoxDecoration(
              color: appState.colors.surfacePrimary,
              borderRadius: BorderRadius.circular(Sizes.cardBorderRadiusL),
            ),
          ),
        );
      },
    );
  }
}

class SkeletonCircle extends StatelessWidget {
  final double radius;
  final EdgeInsetsGeometry margin;

  const SkeletonCircle({
    super.key,
    required this.radius,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return Shimmer.fromColors(
          baseColor: appState.colors.shimmerBase,
          highlightColor: appState.colors.shimmerHighlight,
          child: Container(
            height: radius * 2,
            width: radius * 2,
            margin: margin,
            decoration: BoxDecoration(
              color: appState.colors.surfacePrimary,
              shape: BoxShape.circle,
              // borderRadius: BorderRadius.circular(Sizes.cardBorderRadiusL),
            ),
          ),
        );
      },
    );
  }
}
