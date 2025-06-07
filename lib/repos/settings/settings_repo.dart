part of '../repos.dart';

class SettingsRepo {
  final LocalSettingsRepo _localRepo = LocalSettingsRepo();
  final RemoteSettingsRepo _remoteRepo = RemoteSettingsRepo();

  SettingsRepo._privateConstructor();
  static final SettingsRepo _instance = SettingsRepo._privateConstructor();
  factory SettingsRepo() {
    return _instance;
  }

  Future<void> saveAppSettings(AppSettings settings) async {
    await _localRepo.saveAppSettings(settings);
    _remoteRepo.saveAppSettings(settings);
  }

  Future<AppSettings> getAppSettings(
    { ValueChanged<AppSettings>? onRemoteFetch}
  ) async {
    _remoteRepo.getAppSettings().then((e) => onRemoteFetch?.call(e));
    return await _localRepo.getAppSettings();
  }
}
