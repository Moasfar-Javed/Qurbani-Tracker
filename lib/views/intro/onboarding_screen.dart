import 'package:animate_gradient/animate_gradient.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:qurbani_tracker/app/app_cubit.dart';
import 'package:qurbani_tracker/components/components.dart';
import 'package:qurbani_tracker/constants/constants.dart';
import 'package:qurbani_tracker/theme/theme.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: AnimateGradient(
                        primaryColors: [
                          appState.colors.surfacePrimary,
                          ConstantColors.slate600,
                        ],
                        secondaryColors: [
                          ConstantColors.primary800,
                          appState.colors.surfacePrimary,
                        ],
                        duration: Duration(seconds: 10),
                        primaryBeginGeometry: const AlignmentDirectional(0, 1),
                        primaryEndGeometry: const AlignmentDirectional(0, 2),
                        secondaryBeginGeometry: const AlignmentDirectional(
                          2,
                          0,
                        ),
                        secondaryEndGeometry: const AlignmentDirectional(
                          0,
                          -0.8,
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: SvgPicture.asset(Assets.onboardingAbstractLines),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                        Assets.onboardingAbstractCurvedLines,
                      ),
                    ),
                    Positioned(
                      top: 130,
                      right: -50,
                      child: Lottie.asset(
                        Assets.lottieSpinningTwinkle,
                        addRepaintBoundary: true,
                        width: 350,
                        height: 350,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      bottom: 210,
                      left: -60,
                      child: Lottie.asset(
                        Assets.lottieSpinningTwinkle,
                        addRepaintBoundary: true,
                        width: 250,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: Paddings.horizontalScreenInsets(context),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Spacer(),
                            Center(
                              child: Lottie.asset(
                                Assets.lottieCowOnboarding,
                                repeat: false,
                                addRepaintBoundary: true,
                                width: 250,
                                height: 250,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Spacer(),
                            Animate(
                              delay: Durations.extralong1,
                              effects: [
                                FadeEffect(duration: Durations.extralong1),

                                SlideEffect(
                                  duration: Durations.extralong1,
                                  begin: Offset(0, 1),
                                ),
                              ],
                              child: Text(
                                "Whether you're planning for yourself or the whole family, Qurbani Pal makes it easy to calculate your Qurbani shares"
                                    .tr(),
                                textAlign: TextAlign.center,
                                style: FontStyles.style(
                                  size: FontSize.bodyLarge,
                                  textColor: appState.colors.textPrimary,
                                ),
                              ),
                            ),
                            Spacing(size: SpacingSize.xLarge),
                            Animate(
                              delay: Durations.extralong4,
                              effects: [
                                FadeEffect(duration: Durations.extralong1),
                              ],

                              child: Button(
                                label: "Get Started".tr(),
                                roundedEdges: true,
                                onTap: () {
                                  // TODO: update settings
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.home,
                                    (_) => false,
                                  );
                                },
                                icon: Icon(
                                  CupertinoIcons.arrow_right,
                                  color: appState.colors.onPrimary,
                                ),
                              ),
                            ),
                            Spacing(size: SpacingSize.pageTopBottom),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
