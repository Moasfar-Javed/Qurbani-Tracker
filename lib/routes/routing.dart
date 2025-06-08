part of 'routes.dart';

class Routing {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final List<String> _fullScreenDialogs = [
    // TODO: add calculations route here later
  ];

  static Route<dynamic> routeTable(RouteSettings settings) {
    Widget page = _routeNameMapper(settings);

    return CupertinoPageRoute<dynamic>(
      settings: settings,
      fullscreenDialog: _fullScreenDialogs.contains(settings.name),
      builder: (_) => page,
    );
  }

  static Widget _routeNameMapper(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return const SplashScreen();
      case Routes.onboarding:
        return const OnboardingScreen();
      case Routes.home:
        return const HomeScreen();
      case Routes.qurbani:
        return QurbaniScreen(args: settings.arguments as QurbaniScreenArgs);
      default:
        return const SplashScreen();
    }
  }
}
