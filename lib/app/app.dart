import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:qurbani_tracker/app/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurbani_tracker/constants/constants.dart';
import 'package:qurbani_tracker/routes/routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // context.read<AppBloc>().connectSocket();
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // final bloc = context.read<AppBloc>();
    switch (state) {
      case AppLifecycleState.resumed:
        {
          if (context.mounted) {
            // bloc.connectSocket();
            // bloc.initializeConnListener();
          }
          break;
        }
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        {
          if (context.mounted) {
            // bloc.disconnectSocket();
            // bloc.disposeConnListener();
          }
          break;
        }
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return BlocConsumer<AppCubit, AppState>(
      buildWhen: (previous, current) {
        return current is AppInitial ||
            current is AppLoaded ||
            current is AppReady;
      },
      listener: (listenerContext, state) async {
        if (state is AppReady) {
          await context.setLocale(
            Locale(
              state.locale.isEmpty ? Languages.defaultLocale : state.locale,
            ),
          );
          if (state.nextRoute == Routes.login && buildContext.mounted) {
            Navigator.of(
              Routing.navigatorKey.currentContext ?? buildContext,
            ).pushNamedAndRemoveUntil(Routes.login, (e) => false);
            listenerContext.read<AppCubit>().refresh();
          }
        }
      },
      builder: (builderContext, state) {
        return MaterialApp(
          title: Keys.appName,
          debugShowCheckedModeBanner: false,
          theme: state.themeData,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(),
          locale: state.locale.isEmpty
              ? Languages.fallback
              : Locale(state.locale),
          initialRoute: Routes.splash,
          // home: WidgetTestScreen(),
          navigatorKey: Routing.navigatorKey,
          onGenerateRoute: Routing.routeTable,
        );
      },
    );
  }
}
