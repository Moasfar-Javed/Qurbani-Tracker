part of '../components.dart';

class LineLoader extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  const LineLoader({super.key, this.color, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        Color? lineColor = color;
        Color? lineBgColor = backgroundColor;
        lineColor ??= appState.colors.loader;
        lineBgColor ??= appState.colors.loaderBackground;
        return Center(
          child: LinearProgressIndicator(
            color: lineColor,
            borderRadius: BorderRadius.circular(Sizes.cardBorderRadiusXl),
            backgroundColor: lineBgColor,
          ),
        );
      },
    );
  }
}
