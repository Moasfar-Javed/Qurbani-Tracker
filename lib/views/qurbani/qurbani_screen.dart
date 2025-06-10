import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:qurbani_tracker/app/app_cubit.dart';
import 'package:qurbani_tracker/components/components.dart';
import 'package:qurbani_tracker/constants/constants.dart';
import 'package:qurbani_tracker/models/models.dart';
import 'package:qurbani_tracker/theme/theme.dart';
import 'package:qurbani_tracker/views/qurbani/qurbani_cubit.dart';

class QurbaniScreen extends StatelessWidget {
  final QurbaniScreenArgs args;
  const QurbaniScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QurbaniCubit(args.qurbani)..initialize(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, appState) {
          return BlocBuilder<QurbaniCubit, QurbaniState>(
            builder: (context, state) {
              return CupertinoPageScaffold(
                navigationBar: _buildAppbar(appState, context),
                child: CustomScrollView(
                  slivers: [_buildBody(appState, context, state)],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBody(
    AppState appState,
    BuildContext context,
    QurbaniState state,
  ) {
    return SliverToBoxAdapter(
      child: SafeArea(
        top: false,
        child: Padding(
          padding: Paddings.horizontalScreenInsets(context),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (state is QurbaniInitial || state is QurbaniLoading) {
                return _buildLoading(constraints);
              } else if (state is QurbaniReady) {
                return _buildReady(appState, context, state);
              } else {
                // TODO: add load error condition here
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildReady(
    AppState appState,
    BuildContext context,
    QurbaniReady state,
  ) {
    return Column(
      children: [
        Spacing(size: SpacingSize.pageTopBottom),
        Spacing(),
        if (state.spendings.isEmpty) _buildEmpty() else Column(children: []),
      ],
    );
  }

  Widget _buildLoading(BoxConstraints constraints) {
    return Column(
      children: AnimateList(
        effects: [FadeEffect(), SlideEffect()],
        interval: Duration(milliseconds: 50),
        delay: Duration(milliseconds: 100),
        children: [
          Skeleton.rect(width: constraints.maxWidth, height: 80),
          Spacing(),
          Skeleton.rect(width: constraints.maxWidth, height: 80),
          Spacing(),
          Skeleton.rect(width: constraints.maxWidth, height: 80),
          Spacing(),
          Skeleton.rect(width: constraints.maxWidth, height: 80),
          Spacing(),
          Skeleton.rect(width: constraints.maxWidth, height: 80),
          Spacing(),
          Skeleton.rect(width: constraints.maxWidth, height: 80),
          Spacing(),
          Skeleton.rect(width: constraints.maxWidth, height: 80),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Column(
      children: [
        Center(
          child: Lottie.asset(
            Assets.lottieEmptyList,
            addRepaintBoundary: true,
            repeat: false,
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
        ),
        Spacing(),
        Text(
          "No spendings yet, start by adding".tr(),
          style: FontStyles.style(size: FontSize.body),
        ),
      ],
    );
  }

  CupertinoNavigationBar _buildAppbar(AppState appState, BuildContext context) {
    return CupertinoNavigationBar(
      middle: Text(
        args.qurbani.title,
        overflow: TextOverflow.ellipsis,
        style: FontStyles.style(size: FontSize.heading),
      ),
      backgroundColor: appState.colors.surfaceSecondary.withAlpha(100),
      border: Border(bottom: BorderSide(color: appState.colors.dividerColor)),
      automaticallyImplyLeading: false,
      leading: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.back,
              size: Sizes.mediumIcon,
              color: appState.colors.primaryColor,
            ),
            Text(
              'Home'.tr(),
              style: FontStyles.style(
                size: FontSize.bodyLarge,
                textColor: appState.colors.primaryColor,
              ),
            ),
          ],
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(CupertinoIcons.gear, size: Sizes.mediumIcon),
        onPressed: () {},
      ),
    );
  }
}
