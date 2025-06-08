part of '../repos.dart';

class LocalQurbaniRepo {
  LocalQurbaniRepo._privateConstructor();
  static final LocalQurbaniRepo _instance =
      LocalQurbaniRepo._privateConstructor();
  factory LocalQurbaniRepo() {
    return _instance;
  }

  //-- Qurbani

  Future<void> refreshQurbanis(List<QurbaniModel> qurbanis) async {
    try {
      final db = await LocalDatabase.getDb();

      await db.transaction((txn) async {
        await txn.delete(Keys.dbQurbanisTable);

        for (var qurbani in qurbanis) {
          Map<String, Object?> data = {
            'identifier': qurbani.identifier,
            'value': json.encode(qurbani.toJson()),
            Keys.dbUpdatedOn: qurbani.updatedOn.toIso8601String(),
            Keys.dbCreatedOn: qurbani.createdOn.toIso8601String(),
          };

          await txn.insert(
            Keys.dbQurbanisTable,
            data,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
    } catch (e) {
      debugPrint('Failed to refresh qurbanis: $e');
    }
  }

  Future<void> saveQurbani(QurbaniModel qurbani) async {
    try {
      final db = await LocalDatabase.getDb();

      Map<String, Object?> data = {
        'identifier': qurbani.identifier,
        'value': json.encode(qurbani.toJson()),
        Keys.dbUpdatedOn: qurbani.updatedOn.toIso8601String(),
        Keys.dbCreatedOn: qurbani.createdOn.toIso8601String(),
      };

      await db.insert(
        Keys.dbQurbanisTable,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint('Failed to save qurbani: $e');
    }
  }

  Future<QurbaniListResponse> getQurbanis() async {
    try {
      final db = await LocalDatabase.getDb();

      final List<Map<String, dynamic>> result = await db.query(
        Keys.dbQurbanisTable,
        orderBy: '${Keys.dbUpdatedOn} DESC',
      );

      if (result.isNotEmpty) {
        return QurbaniListResponse.success(
          result
              .map(
                (e) => (
                  json.decode(e["value"]) as Map<String, dynamic>,
                  e["identifier"] as String,
                ),
              )
              .toList(),
        );
      }
    } catch (e) {
      return QurbaniListResponse.error();
    }
    return QurbaniListResponse.error();
  }

  //-- Expenses

  Future<void> refreshExpenses(List<ExpenseModel> expenses) async {
    try {
      final db = await LocalDatabase.getDb();

      await db.transaction((txn) async {
        await txn.delete(Keys.dbExpensesTable);

        for (var expense in expenses) {
          Map<String, Object?> data = {
            'identifier': expense.identifier,
            'qurbaniIdentifier': expense.qurbaniIdentifier,
            'value': json.encode(expense.toJson()),
            Keys.dbUpdatedOn: expense.updatedOn.toIso8601String(),
            Keys.dbCreatedOn: expense.createdOn.toIso8601String(),
          };

          await txn.insert(
            Keys.dbExpensesTable,
            data,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
    } catch (e) {
      debugPrint('Failed to refresh expenses: $e');
    }
  }

  Future<void> saveExpense(ExpenseModel expense) async {
    try {
      final db = await LocalDatabase.getDb();

      Map<String, Object?> data = {
        'identifier': expense.identifier,
        'qurbaniIdentifier': expense.qurbaniIdentifier,
        'value': json.encode(expense.toJson()),
        Keys.dbUpdatedOn: expense.updatedOn.toIso8601String(),
        Keys.dbCreatedOn: expense.createdOn.toIso8601String(),
      };

      await db.insert(
        Keys.dbExpensesTable,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint('Failed to save expense: $e');
    }
  }

  Future<void> deleteExpense(ExpenseModel expense) async {
    try {
      final db = await LocalDatabase.getDb();

      await db.delete(
        Keys.dbExpensesTable,
        where: 'identifier = ? AND qurbaniIdentifier = ?',
        whereArgs: [expense.identifier, expense.qurbaniIdentifier],
      );
    } catch (e) {
      debugPrint('Failed to delete expense: $e');
    }
  }

  Future<ExpenseListResponse> getExpenses(String qurbaniIdentifier) async {
    try {
      final db = await LocalDatabase.getDb();

      final List<Map<String, dynamic>> result = await db.query(
        Keys.dbExpensesTable,
        where: 'qurbaniIdentifier = ?',
        whereArgs: [qurbaniIdentifier],
        orderBy: '${Keys.dbUpdatedOn} DESC',
      );

      if (result.isNotEmpty) {
        return ExpenseListResponse.success(
          result
              .map(
                (e) => (
                  json.decode(e["value"]) as Map<String, dynamic>,
                  e["identifier"] as String,
                  e["qurbaniIdentifier"] as String,
                ),
              )
              .toList(),
        );
      }
    } catch (e) {
      return ExpenseListResponse.error();
    }
    return ExpenseListResponse.error();
  }

  //-- Contributions

  Future<void> refreshContributions(List<ContributionModel> expenses) async {
    try {
      final db = await LocalDatabase.getDb();

      await db.transaction((txn) async {
        await txn.delete(Keys.dbContributionsTable);

        for (var expense in expenses) {
          Map<String, Object?> data = {
            'identifier': expense.identifier,
            'qurbaniIdentifier': expense.qurbaniIdentifier,
            'value': json.encode(expense.toJson()),
            Keys.dbUpdatedOn: expense.updatedOn.toIso8601String(),
            Keys.dbCreatedOn: expense.createdOn.toIso8601String(),
          };

          await txn.insert(
            Keys.dbContributionsTable,
            data,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
    } catch (e) {
      debugPrint('Failed to refresh contributions: $e');
    }
  }

  Future<void> saveContribution(ContributionModel expense) async {
    try {
      final db = await LocalDatabase.getDb();

      Map<String, Object?> data = {
        'identifier': expense.identifier,
        'qurbaniIdentifier': expense.qurbaniIdentifier,
        'value': json.encode(expense.toJson()),
        Keys.dbUpdatedOn: expense.updatedOn.toIso8601String(),
        Keys.dbCreatedOn: expense.createdOn.toIso8601String(),
      };

      await db.insert(
        Keys.dbContributionsTable,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint('Failed to save contribution: $e');
    }
  }

  Future<void> deleteContribution(ContributionModel expense) async {
    try {
      final db = await LocalDatabase.getDb();

      await db.delete(
        Keys.dbContributionsTable,
        where: 'identifier = ? AND qurbaniIdentifier = ?',
        whereArgs: [expense.identifier, expense.qurbaniIdentifier],
      );
    } catch (e) {
      debugPrint('Failed to delete contribution: $e');
    }
  }

  Future<ContributionListResponse> getContributions(
    String qurbaniIdentifier,
  ) async {
    try {
      final db = await LocalDatabase.getDb();

      final List<Map<String, dynamic>> result = await db.query(
        Keys.dbContributionsTable,
        where: 'qurbaniIdentifier = ?',
        whereArgs: [qurbaniIdentifier],
        orderBy: '${Keys.dbUpdatedOn} DESC',
      );

      if (result.isNotEmpty) {
        return ContributionListResponse.success(
          result
              .map(
                (e) => (
                  json.decode(e["value"]) as Map<String, dynamic>,
                  e["identifier"] as String,
                  e["qurbaniIdentifier"] as String,
                ),
              )
              .toList(),
        );
      }
    } catch (e) {
      return ContributionListResponse.error();
    }
    return ContributionListResponse.error();
  }
}
