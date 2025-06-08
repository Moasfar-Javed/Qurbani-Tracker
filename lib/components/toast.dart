part of 'components.dart';

class Toast {
  static void dismiss() {
    SmartDialog.dismiss(status: SmartStatus.allToast);
  }

  static void show({
    required String message,
    required ToastType type,
    ToastOverflow overflow = ToastOverflow.expanded,
    bool showDismiss = true,
    bool hapticsEnabled = true,
    String? action,
    VoidCallback? onAction,
    Alignment alignment = Alignment.topCenter,
  }) {
    assert(
      (action == null && onAction == null) ||
          (action != null && onAction != null),
      'Both `action` and `onAction` must be provided together or neither should be provided.',
    );

    Duration toastDuration = const Duration(seconds: 3);
    if (action != null) {
      toastDuration = const Duration(seconds: 5);
    }

    SmartDialog.showToast(
      '',
      alignment: alignment,
      displayTime: toastDuration,
      animationTime: Durations.short3,
      displayType: SmartToastType.last,
      consumeEvent: true,
      builder: (context) => EssentialToast(
        message: message,
        overflow: overflow,
        type: type,
        showDismiss: showDismiss,
        action: action,
        onAction: onAction,
      ),
    );

    if (hapticsEnabled) _activateHaptics(type);
  }

  static _activateHaptics(ToastType type) {
    switch (type) {
      case ToastType.success:
        HapticUtil.trigger(Haptics.success);
      case ToastType.info:
        HapticUtil.trigger(Haptics.nudge);
      case ToastType.danger:
        HapticUtil.trigger(Haptics.error);
    }
  }
}

class EssentialToast extends StatelessWidget {
  final String message;
  final ToastType type;
  final ToastOverflow overflow;
  final bool showDismiss;
  final String? action;
  final VoidCallback? onAction;

  const EssentialToast({
    super.key,
    required this.message,
    required this.type,
    required this.overflow,
    required this.showDismiss,
    required this.action,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final text = Text(
      message,
      maxLines: overflow == ToastOverflow.truncated ? 1 : null,
      overflow: overflow == ToastOverflow.truncated
          ? TextOverflow.ellipsis
          : null,
      style: FontStyles.style(
        size: FontSize.label,
        textColor: ConstantColors.white,
      ),
    );

    Widget? dismissButton, actionButton;

    if (showDismiss) {
      dismissButton = const SizedBox(
        width: Sizes.regularIcon,
        height: Sizes.regularIcon,
        child: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(
            Icons.close,
            color: ConstantColors.white,
            size: Sizes.iconButtonIcon,
          ),
          visualDensity: VisualDensity.compact,
          onPressed: Toast.dismiss,
        ),
      );
    }

    if (action != null) {
      actionButton = SizedBox(
        height: Sizes.regularIcon,
        width: Sizes.toastActionWidth,
        child: CupertinoButton(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.toastActionPadding,
          ),
          pressedOpacity: .9,
          onPressed: onAction,
          child: FittedBox(
            child: Text(
              action!,
              style: FontStyles.style(
                size: FontSize.labelBold,
                textColor: _actionColor(),
              ),
            ),
          ),
        ),
      );
    }

    double maxTextAreaAvailable =
        MediaQuery.sizeOf(context).width -
        (Sizes.toastHorizontalPadding * 4) -
        (showDismiss ? Sizes.iconButtonSize : 0) -
        (action != null ? Sizes.toastActionWidth : 0);

    bool shouldPreferColumn = overflow == ToastOverflow.truncated
        ? false
        : _willTextOverflow(
            message,
            FontStyles.style(
              size: FontSize.label,
              textColor: ConstantColors.white,
            ),
            maxTextAreaAvailable,
          );
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.toastHorizontalPadding,
          vertical: Sizes.toastVerticalPadding,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: Sizes.toastHorizontalPadding,
          vertical: Sizes.toastVerticalPadding,
        ),
        decoration: BoxDecoration(
          color: _backgroundColor(),
          borderRadius: BorderRadius.circular(Sizes.cardBorderRadiusXl),
          boxShadow: [Decorations.toastHardShadow, Decorations.toastSoftShadow],
        ),
        child: _buildToastContents(
          shouldPreferColumn,
          text,
          actionButton,
          dismissButton,
        ),
      ),
    );
  }

  Color _actionColor() {
    Color actionColor;
    switch (type) {
      case ToastType.success:
        actionColor = ConstantColors.success100;
      case ToastType.info:
        actionColor = ConstantColors.primary100;
      case ToastType.danger:
        actionColor = ConstantColors.danger100;
    }
    return actionColor;
  }

  Color _backgroundColor() {
    Color backgroundColor;
    switch (type) {
      case ToastType.success:
        backgroundColor = ConstantColors.success600;
      case ToastType.info:
        backgroundColor = ConstantColors.primary400;
      case ToastType.danger:
        backgroundColor = ConstantColors.danger500;
    }
    return backgroundColor;
  }

  Widget _buildToastContents(
    bool shouldPreferColumn,
    Widget text,
    Widget? actionButton,
    Widget? dismissButton,
  ) {
    if (!shouldPreferColumn) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: text),
          actionButton ?? const SizedBox.shrink(),
          dismissButton ?? const SizedBox.shrink(),
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              actionButton ?? const SizedBox.shrink(),
              dismissButton ?? const SizedBox.shrink(),
            ],
          ),
        ],
      );
    }
  }

  bool _willTextOverflow(String text, TextStyle style, double containerWidth) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: FontStyles.getTextDirection(),
    );

    textPainter.layout();

    return textPainter.size.width > containerWidth;
  }
}
