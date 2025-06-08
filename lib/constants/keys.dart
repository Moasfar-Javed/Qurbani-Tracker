// ignore_for_file: constant_identifier_names

part of 'constants.dart';

class Keys {
  // - Config
  static const String appName = 'Qurbani';

  // - Database
  static const String dbName = 'qurbani_app_database.db';

  // -- Tables
  static const String dbHistoryTable = 'appDatabaseHistory';
  static const String dbMetadataTable = 'metadata';
  static const String dbUserMetadataTable = 'userMetadata';
  static const String dbSettingsTable = 'settings';
  static const String dbQurbanisTable = 'qurbanis';
  static const String dbExpensesTable = 'expenses';
  static const String dbContributionsTable = 'contributions';

  static const List<String> clearOnLogoutTables = [dbUserMetadataTable];

  // -- Columns/Keys
  static const String dbCreatedOn = 'createdOn';
  static const String dbUpdatedOn = 'updatedOn';
  static const String dbMK_Keys = 'keys';
  static const String k_AppSettings = 'appSettings';
  static const String k_Users = 'users';
}
