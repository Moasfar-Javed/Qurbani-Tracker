import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurbani_tracker/app/app_cubit.dart';
import 'package:qurbani_tracker/constants/constants.dart';
import 'package:qurbani_tracker/theme/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) async {
        if (state is AppReady) {
          // if (!state.appSettings.isUserOnboarded) {
          //   Navigator.of(context).pushReplacementNamed(Routes.onboarding);
          // } else {
          Navigator.of(context).pushReplacementNamed(Routes.home);
          // }
        }
      },
      builder: (context, state) {
        bool isDark = state.theme == AppTheme.dark;
        return Scaffold(
          backgroundColor: isDark
              ? ConstantColors.slate800
              : ConstantColors.slate50,
          body: Stack(
            children: [
              Center(
                child: Image.asset(
                  width: Sizes.splashImageSize.$1,
                  height: Sizes.splashImageSize.$2,
                  isDark ? Assets.logoDark : Assets.logoLight,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: Sizes.spacingXL),
                    child: Animate(
                      effects: [ScaleEffect()],

                      child: Text(
                        "Qurbani Pal".tr(),
                        textAlign: TextAlign.center,
                        style: FontStyles.style(
                          size: FontSize.headingBold,
                          textColor: state.colors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
