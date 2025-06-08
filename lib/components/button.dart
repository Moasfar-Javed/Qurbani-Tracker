part of './components.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final ButtonType type;
  final bool isLoading;
  final bool isExpanded;
  final bool isEnabled;
  final bool roundedEdges;
  final Haptics? haptic;
  final Icon? icon;
  final HorizontalAlignment iconAlignment;

  const Button({
    super.key,
    required this.label,
    required this.onTap,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.isExpanded = true,
    this.isEnabled = true,
    this.roundedEdges = false,
    this.haptic = Haptics.selection,
    this.icon,
    this.iconAlignment = HorizontalAlignment.right,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: !isEnabled || isLoading,
          child: SizedBox(
            height: type == ButtonType.textOnly
                ? Sizes.textButtonHeight
                : Sizes.buttonHeight,
            width: isExpanded ? double.maxFinite : null,
            child: _buildComponent(state, context),
          ),
        );
      },
    );
  }

  Widget _buildComponent(AppState state, BuildContext context) {
    return _buildCupertinoButton(state);
  }

  _buildCupertinoButton(AppState state) {
    return CupertinoButton(
      onPressed: () => _onTap(),
      padding: _getPadding(),
      color: _getCupertinoBackgroundColor(state),
      pressedOpacity: 0.7,
      borderRadius: BorderRadius.circular(
        roundedEdges
            ? Sizes.cardBorderRadiusCircular
            : Sizes.buttonBorderRadius,
      ),
      child: _buildChild(state),
    );
  }

  Widget _buildChild(AppState state) {
    final text = Opacity(
      opacity: isEnabled ? 1 : .5,
      child: Text(
        label,
        maxLines: 1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: FontStyles.style(
          size: type == ButtonType.textOnly
              ? FontSize.body
              : FontSize.bodyLarge,
          textColor: _getTextColor(
            state,
          ).withValues(alpha: isEnabled ? 1 : 0.8),
        ),
      ),
    );
    const spacing = Spacing(size: SpacingSize.xSmall);
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: isLoading
          ? Spinner(
              color: _getTextColor(
                state,
              ).withValues(alpha: isEnabled ? 1 : 0.8),
            )
          : icon != null
          ? Row(
              children: iconAlignment == HorizontalAlignment.left
                  ? [
                      Opacity(opacity: isEnabled ? 1 : .5, child: icon),
                      spacing,
                      text,
                    ]
                  : [
                      text,
                      spacing,
                      Opacity(opacity: isEnabled ? 1 : .5, child: icon!),
                    ],
            )
          : text,
    );
  }

  Color _getTextColor(AppState appState) {
    switch (type) {
      case ButtonType.primary:
        return appState.colors.primaryButtonText;
      case ButtonType.danger:
        return appState.colors.dangerButtonText;
      case ButtonType.textOnly:
        return appState.colors.textButtonText;
    }
  }

  EdgeInsets _getPadding() {
    return EdgeInsets.symmetric(
      horizontal: !isExpanded
          ? Sizes.buttonHorizontalPaddingM
          : Sizes.buttonHorizontalPaddingL,
    );
  }

  Color _getCupertinoBackgroundColor(AppState appState) {
    Color backgroundColor;
    switch (type) {
      case ButtonType.primary:
        backgroundColor = appState.colors.primaryButton;
        break;

      case ButtonType.danger:
        backgroundColor = appState.colors.dangerButton;
        break;

      case ButtonType.textOnly:
        backgroundColor = appState.colors.textButton;
        break;
    }

    if (!isEnabled) {
      backgroundColor = type == ButtonType.textOnly
          ? backgroundColor
          : backgroundColor.withValues(alpha: 0.6);
    }
    return backgroundColor;
  }

  _onTap() {
    if (!isLoading && isEnabled) {
      if (haptic != null) {
        HapticUtil.trigger(haptic!);
      }
      onTap();
    }
  }
}
