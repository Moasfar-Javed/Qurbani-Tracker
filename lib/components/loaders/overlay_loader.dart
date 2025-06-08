part of '../components.dart';

class OverlayLoader {
  static showLoader({
    OverlayLoaderType loaderType = OverlayLoaderType.circular,

    Color? color,
  }) => SmartDialog.showLoading(
    backType: SmartBackType.ignore,
    maskColor: ConstantColors.slate800.withValues(alpha: 0.6),
    builder: (_) => OverlayLoaderWidget(loaderType: loaderType, color: color),
  );

  static dismiss() => SmartDialog.dismiss();
}

class OverlayLoaderWidget extends StatefulWidget {
  final OverlayLoaderType loaderType;
  final Color? color;

  const OverlayLoaderWidget({super.key, required this.loaderType, this.color});

  @override
  State<OverlayLoaderWidget> createState() => _OverlayLoaderWidgetState();
}

class _OverlayLoaderWidgetState extends State<OverlayLoaderWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _initializeAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _initializeAnimation() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        var loaderColor = widget.color ?? ConstantColors.slate50;
        return Stack(
          children: [
            Visibility(
              visible: widget.loaderType == OverlayLoaderType.circular,
              child: Spinner(
                color: loaderColor,
                
              ),
            ),
            Visibility(
              visible: widget.loaderType == OverlayLoaderType.line,
              child: Padding(
                padding: Paddings.horizontalScreenInsets(context),
                child: LineLoader(
                  color: loaderColor,
                  backgroundColor: ConstantColors.slate400,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
