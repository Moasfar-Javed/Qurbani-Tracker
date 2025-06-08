import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:qurbani_tracker/constants/constants.dart';
import 'package:qurbani_tracker/models/models.dart';
import 'package:qurbani_tracker/repos/repos.dart';
import 'package:qurbani_tracker/theme/theme.dart';
import 'package:qurbani_tracker/utility/utility.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
    : super(AppInitial(AppTheme.light, DarkColors(), AppThemes.darkTheme, ''));

  final SettingsRepo _settingsRepo = SettingsRepo();
  final AuthRepo _authRepo = AuthRepo();
  final ConnectivityListener _connectivityListener = ConnectivityListener();

  Future<void> initialize() async {
    initializeConnListener();
    await _loadAppPrefs();
  }

  Future<void> _loadAppPrefs() async {
    try {
      AppSettings settings = await _settingsRepo.getAppSettings();
      AppTheme theme = settings.theme;
      String locale = settings.locale;

      emit(
        AppLoaded(
          theme,
          _getThemeColors(theme),
          _getThemeData(theme),
          locale,
          appSettings: settings,
        ),
      );

      if (!settings.isUserLoggedIn) {
        await _authRepo.initializeAuthAndGetSettings();
      }

      emit(
        AppReady(
          theme,
          _getThemeColors(theme),
          _getThemeData(theme),
          locale,
          appSettings: settings,
          nextRoute: null,
        ),
      );
    } catch (e) {
      // todo: handle
      print(e);
    }
  }

  Future<void> setTheme(AppTheme theme) async {
    final settings = await _settingsRepo.getAppSettings();
    if (theme == settings.theme) return;

    settings.theme = theme;
    await _settingsRepo.saveAppSettings(settings);
    emit(
      AppReady(
        theme,
        _getThemeColors(theme),
        _getThemeData(theme),
        settings.locale,
        appSettings: settings,
        nextRoute: null,
      ),
    );
  }

  Future<void> setLocale(String locale) async {
    final settings = await _settingsRepo.getAppSettings();
    if (locale == settings.locale) return;

    settings.locale = locale;
    await _settingsRepo.saveAppSettings(settings);
    emit(
      AppReady(
        settings.theme,
        _getThemeColors(settings.theme),
        _getThemeData(settings.theme),
        locale,
        appSettings: settings,
        nextRoute: null,
      ),
    );
  }

  Future<void> refresh() async {
    final settings = await _settingsRepo.getAppSettings();
    emit(
      AppReady(
        settings.theme,
        _getThemeColors(settings.theme),
        _getThemeData(settings.theme),
        settings.locale,
        appSettings: settings,
        nextRoute: null,
      ),
    );
  }

  void reload() {
    if (!isClosed) {
      initialize();
    }
  }

  void initializeConnListener() => _connectivityListener.initialize();
  void disposeConnListener() => _connectivityListener.dispose();

  CupertinoThemeData _getThemeData(AppTheme theme) {
    return AppThemes.darkTheme;
    // uncomment when dark theme is added
    // return theme == AppTheme.dark ? AppThemes.darkTheme : AppThemes.lightTheme;
  }

  AppColors _getThemeColors(AppTheme theme) {
    return DarkColors();
    // uncomment when dark theme is added
    // return theme == AppTheme.dark ? DarkColors() : LightColors();
  }
}
