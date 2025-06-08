import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurbani_tracker/app/app_cubit.dart';
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
      create: (context) => QurbaniCubit()..initialize(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, appState) {
          return BlocBuilder<QurbaniCubit, QurbaniState>(
            builder: (context, state) {
              return CupertinoPageScaffold(
                navigationBar: _buildAppbar(appState, context),
                child: CustomScrollView(
                  slivers: [
                    // _buildBody(appState, context, state),
                  ],
                ),
              );
            },
          );
        },
      ),
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
