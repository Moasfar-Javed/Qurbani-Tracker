part of '../repos.dart';

class LocalSettingsRepo {
  LocalSettingsRepo._privateConstructor();
  static final LocalSettingsRepo _instance =
      LocalSettingsRepo._privateConstructor();
  factory LocalSettingsRepo() {
    return _instance;
  }

  Future<void> saveAppSettings(AppSettings settings) async {
    try {
      final db = await LocalDatabase.getDb();

      final settingsMap = settings.toJson();
      settingsMap[Keys.dbCreatedOn] = DateTime.now().toIso8601String();

      final batch = db.batch();
      batch.delete(Keys.dbSettingsTable);
      batch.insert(
        Keys.dbSettingsTable,
        settingsMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      await batch.commit(noResult: true);
    } catch (e) {
      debugPrint('Failed to save app settings: $e');
    }
  }

  Future<AppSettings> getAppSettings() async {
    try {
      final db = await LocalDatabase.getDb();
      final maps = await db.query(Keys.dbSettingsTable);

      if (maps.isNotEmpty) {
        return AppSettings.fromJson(maps.first);
      }
    } catch (e) {
      debugPrint('Failed to get app settings: $e');
    }
    return AppSettings.defaultSettings;
  }
}
