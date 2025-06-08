part of 'utility.dart';

class LocalDatabase {
  static Future<void> initialize() async {
    final dbVersion = 1;
    final dbPath = join(await getDatabasesPath(), Keys.dbName);
    debugPrint("DB Version: $dbVersion");
    debugPrint(dbPath);
    await openDatabase(
      dbPath,
      version: dbVersion,
      onCreate: (db, version) async {
        await createLocalDatabase(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {},
    );
  }

  static Future<Database> getDb() async {
    return openDatabase(join(await getDatabasesPath(), Keys.dbName));
  }

  static Future<void> clearTables() async {
    try {
      final db = await LocalDatabase.getDb();

      final batch = db.batch();

      for (var table in Keys.clearOnLogoutTables) {
        batch.delete(table);
      }

      await batch.commit(noResult: true);
    } catch (e) {
      debugPrint('Failed to clear tables: $e');
    }
  }

  static Future createLocalDatabase(Database db) async {
    var batch = db.batch();

    // app DB history table
    batch.execute('''CREATE TABLE IF NOT EXISTS ${Keys.dbHistoryTable}(
        version TEXT PRIMARY KEY, 
        major INTEGER, 
        minor INTEGER, 
        patch INTEGER, 
        ${Keys.dbCreatedOn} TEXT)
      ''');

    // metadata table (persists across users)
    batch.execute('''CREATE TABLE IF NOT EXISTS ${Keys.dbMetadataTable}(
        key TEXT PRIMARY KEY, 
        value TEXT, 
        ${Keys.dbCreatedOn} TEXT)
      ''');

    // user metadata table (persists per user)
    batch.execute('''CREATE TABLE IF NOT EXISTS ${Keys.dbUserMetadataTable}(
        key TEXT PRIMARY KEY, 
        value TEXT, 
        ${Keys.dbCreatedOn} TEXT)
      ''');

    // settings table
    batch.execute('''CREATE TABLE IF NOT EXISTS ${Keys.dbSettingsTable}(
        theme INT, 
        locale TEXT, 
        region TEXT, 
        isUserOnboarded INTEGER, 
        isUserLoggedIn INTEGER, 
        ${Keys.dbCreatedOn} TEXT)
      ''');

    // qurbani table
    batch.execute('''CREATE TABLE IF NOT EXISTS ${Keys.dbQurbanisTable}(
        identifier TEXT PRIMARY KEY, 
        value TEXT,
        ${Keys.dbUpdatedOn} TEXT)
        ${Keys.dbCreatedOn} TEXT)
      ''');

    // expenses table
    batch.execute('''CREATE TABLE IF NOT EXISTS ${Keys.dbExpensesTable}(
        identifier TEXT PRIMARY KEY, 
        qurbaniIdentifier TEXT,
        value TEXT,
        ${Keys.dbUpdatedOn} TEXT)
        ${Keys.dbCreatedOn} TEXT)
      ''');

    // contributions table
    batch.execute('''CREATE TABLE IF NOT EXISTS ${Keys.dbContributionsTable}(
        identifier TEXT PRIMARY KEY, 
        qurbaniIdentifier TEXT,
        value TEXT,
        ${Keys.dbUpdatedOn} TEXT)
        ${Keys.dbCreatedOn} TEXT)
      ''');

    // execute all the queries
    await batch.commit(noResult: true);
  }
}
