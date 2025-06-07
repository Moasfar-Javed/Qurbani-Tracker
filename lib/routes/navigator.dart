part of 'routes.dart';

class Routing {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> routeTable(RouteSettings settings) {
    Widget page = _routeNameMapper(settings);

    return MaterialPageRoute<dynamic>(settings: settings, builder: (_) => page);
  }

  static Widget _routeNameMapper(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return const SplashScreen();
      case Routes.onboarding:
        return const OnboardingScreen();

      default:
        return const SplashScreen();
    }
  }
}
