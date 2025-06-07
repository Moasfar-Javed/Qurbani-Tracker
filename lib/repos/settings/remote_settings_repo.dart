part of '../repos.dart';

class RemoteSettingsRepo {
  RemoteSettingsRepo._privateConstructor();
  static final RemoteSettingsRepo _instance =
      RemoteSettingsRepo._privateConstructor();
  factory RemoteSettingsRepo() {
    return _instance;
  }

  Future<void> saveAppSettings(AppSettings settings) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw UserNotAuthenticatedEx();
      }

      final settingsMap = settings.toJson();
      settingsMap[Keys.dbUpdatedOn] = DateTime.now().toUtc().toIso8601String();

      final docRef = FirebaseFirestore.instance
          .collection(Keys.k_Users)
          .doc(user.uid);

      await docRef.set({
        Keys.k_AppSettings: settingsMap,
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Failed to save app settings: $e');
    }
  }

  Future<AppSettings> getAppSettings() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw UserNotAuthenticatedEx();
      }

      final docRef = FirebaseFirestore.instance
          .collection(Keys.k_Users)
          .doc(user.uid);
      final doc = await docRef.get();

      if (doc.exists && doc.data()?[Keys.k_AppSettings] != null) {
        return AppSettings.fromJson(
          Map<String, dynamic>.from(doc[Keys.k_AppSettings]),
        );
      }
    } catch (e) {
      debugPrint('Failed to get app settings: $e');
    }

    return AppSettings.defaultSettings;
  }
}
