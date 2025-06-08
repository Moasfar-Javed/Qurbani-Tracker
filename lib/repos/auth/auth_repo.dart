part of '../repos.dart';

class AuthRepo {
  final SettingsRepo _settingsRepo = SettingsRepo();
  final RemoteAuthRepo _remoteRepo = RemoteAuthRepo();

  AuthRepo._privateConstructor();
  static final AuthRepo _instance = AuthRepo._privateConstructor();
  factory AuthRepo() {
    return _instance;
  }

  Future<AppSettings> initializeAuthAndGetSettings() async {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    if (isLoggedIn) {
      final completer = Completer<AppSettings>();

      _settingsRepo.getAppSettings(
        onRemoteFetch: (appSettings) {
          completer.complete(appSettings ?? AppSettings.defaultSettings);
        },
      );
      return await completer.future;
    } else {
      await _remoteRepo.signInAnonymously();
      await _settingsRepo.saveAppSettings(AppSettings.defaultSettings);
      return AppSettings.defaultSettings;
    }
  }

  Future<void> signInWithGoogle() async {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final isLoggedInUserAnonymous =
        FirebaseAuth.instance.currentUser?.isAnonymous ?? false;
    if (isLoggedIn && isLoggedInUserAnonymous) {
      await _remoteRepo.linkAnonymousWithGoogle();
    } else {
      await _remoteRepo.signInWithGoogle();
    }
  }
}
