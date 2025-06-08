part of '../components.dart';

class Spinner extends StatelessWidget {
  final Color? color;
  const Spinner({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: _buildComponent(appState, context),
          ),
        );
      },
    );
  }

  Widget _buildComponent(AppState state, BuildContext context) {
    Color? spinnerColor = color;
    spinnerColor ??= state.colors.loader;

    return CupertinoActivityIndicator(radius: 10, color: spinnerColor);
  }
}
