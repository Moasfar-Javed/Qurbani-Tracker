import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:qurbani_tracker/app/app_cubit.dart';
import 'package:qurbani_tracker/components/components.dart';
import 'package:qurbani_tracker/constants/constants.dart';
import 'package:qurbani_tracker/models/models.dart';
import 'package:qurbani_tracker/theme/theme.dart';
import 'package:qurbani_tracker/utility/utility.dart';
import 'package:qurbani_tracker/views/home/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..initialize(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, appState) {
          return BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              var cubit = context.read<HomeCubit>();
              return CupertinoPageScaffold(
                child: CustomScrollView(
                  slivers: [
                    _buildAppbar(appState, context, state, cubit),
                    _buildBody(appState, context, state),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBody(AppState appState, BuildContext context, HomeState state) {
    return SliverToBoxAdapter(
      child: SafeArea(
        top: false,
        child: Padding(
          padding: Paddings.horizontalScreenInsets(context),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (state is HomeInitial || state is HomeLoading) {
                return _buildLoading(constraints);
              } else if (state is HomeReady) {
                return _buildReady(appState, context, state);
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
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

  Widget _buildReady(AppState appState, BuildContext context, HomeReady state) {
    return Column(
      children: [
        Spacing(size: SpacingSize.pageTopBottom),
        if (!state.isLoggedIn)
          Animate(
            delay: Durations.extralong4,
            effects: [FadeEffect(duration: Durations.extralong1)],
            child: Container(
              padding: Paddings.cardInsets(context),
              decoration: BoxDecoration(
                color: appState.colors.surfaceSecondary,
                borderRadius: BorderRadius.circular(Sizes.cardBorderRadiusXl),
              ),
              child: Text(
                "Your qurbani data isn't being backed up. To sync your data to the cloud please login by going to the settings and continue to use this app anywhere"
                    .tr(),
                style: FontStyles.style(size: FontSize.body),
              ),
            ),
          ),
        Spacing(),
        if (state.qurbanis.isEmpty) _buildEmpty(),
      ],
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
          "No qurbanis yet, start by creating one".tr(),
          style: FontStyles.style(size: FontSize.body),
        ),
      ],
    );
  }

  CupertinoSliverNavigationBar _buildAppbar(
    AppState appState,
    BuildContext context,
    HomeState state,
    HomeCubit cubit,
  ) {
    return CupertinoSliverNavigationBar(
      largeTitle: Text(
        'Happy Qurbani'.tr(),
        style: FontStyles.style(size: FontSize.titleBlack),
      ),
      middle: Text(
        'Qurbanis'.tr(),
        style: FontStyles.style(size: FontSize.heading),
      ),
      alwaysShowMiddle: false,
      stretch: true,
      backgroundColor: appState.colors.surfaceSecondary.withAlpha(100),
      border: Border(bottom: BorderSide(color: appState.colors.dividerColor)),
      leading: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(CupertinoIcons.gear, size: Sizes.mediumIcon),
        onPressed: () {},
      ),
      trailing: state is HomeReady
          ? CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(CupertinoIcons.add, size: Sizes.mediumIcon),
              onPressed: () async {
                OverlayLoader.showLoader();
                final res = await cubit.createQurbani();
                OverlayLoader.dismiss();
                if (res.isSuccess && context.mounted) {
                  Navigator.of(context).pushNamed(
                    Routes.qurbani,
                    arguments: QurbaniScreenArgs(qurbani: res.data!),
                  );
                } else if (res.message?.isNotEmpty ?? false) {
                  Toast.show(message: res.message!, type: ToastType.danger);
                  HapticUtil.trigger(Haptics.error);
                }
              },
            )
          : null,
    );
  }
}
