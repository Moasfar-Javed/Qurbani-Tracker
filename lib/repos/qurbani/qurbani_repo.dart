part of '../repos.dart';

class QurbaniRepo {
  final LocalQurbaniRepo _localRepo = LocalQurbaniRepo();
  final RemoteQurbaniRepo _remoteRepo = RemoteQurbaniRepo();

  QurbaniRepo._privateConstructor();
  static final QurbaniRepo _instance = QurbaniRepo._privateConstructor();
  factory QurbaniRepo() {
    return _instance;
  }

  //-- Qurbani

  Future<QurbaniListResponse> getQurbanis({
    ValueChanged<List<QurbaniModel>?>? onRemoteFetch,
  }) async {
    var res = await _localRepo.getQurbanis();

    if ((res.data ?? []).isEmpty) {
      res = await _remoteRepo.getQurbanis();
      if (res.status) {
        _localRepo.refreshQurbanis(res.data ?? []);
      }
    } else if (onRemoteFetch != null) {
      try {
        _remoteRepo.getQurbanis().then((e) {
          if (e.status) {
            _localRepo.refreshQurbanis(e.data ?? []);
          }
          onRemoteFetch.call(e.data);
        });
      } catch (e) {
        onRemoteFetch.call(null);
      }
    }

    return res;
  }

  Future<QurbaniCreateResponse> createQurbani(QurbaniModel qurbani) async {
    final res = await _remoteRepo.createQurbani(qurbani);
    if (res.status) {
      await _localRepo.saveQurbani(res.data!);
      return res;
    } else if (!res.status && res.message == "Network error".tr()) {
      qurbani.identifier = Utils.genUuid();
      qurbani.isLocal = true;
      await _localRepo.saveQurbani(qurbani);
      return QurbaniCreateResponse.success(qurbani);
    }
    return QurbaniCreateResponse.error();
  }

  Future<QurbaniSaveResponse> updateQurbani(QurbaniModel qurbani) async {
    final res = await _remoteRepo.updateQurbani(qurbani);
    if (res.status) {
      await _localRepo.saveQurbani(qurbani);
      return res;
    } else if (!res.status && res.message == "Network error".tr()) {
      await _localRepo.saveQurbani(qurbani);
      return QurbaniSaveResponse.success();
    }
    return res;
  }

  //-- Expenses

  Future<ExpenseListResponse> getExpenses(
    String qurbaniIdentifier, {
    ValueChanged<List<ExpenseModel>?>? onRemoteFetch,
  }) async {
    var res = await _localRepo.getExpenses(qurbaniIdentifier);

    if ((res.data ?? []).isEmpty) {
      res = await _remoteRepo.getExpenses(qurbaniIdentifier);
      if (res.status) {
        _localRepo.refreshExpenses(res.data ?? []);
      }
    } else if (onRemoteFetch != null) {
      try {
        _remoteRepo.getExpenses(qurbaniIdentifier).then((e) {
          if (e.status) {
            _localRepo.refreshExpenses(e.data ?? []);
          }
          onRemoteFetch.call(e.data);
        });
      } catch (e) {
        onRemoteFetch.call(null);
      }
    }

    return res;
  }

  Future<ExpenseCreateResponse> createExpense(ExpenseModel expense) async {
    final res = await _remoteRepo.createExpense(expense);
    if (res.status) {
      await _localRepo.saveExpense(res.data!);
      return res;
    } else if (!res.status && res.message == "Network error".tr()) {
      expense.identifier = Utils.genUuid();
      expense.isLocal = true;
      await _localRepo.saveExpense(expense);
      return ExpenseCreateResponse.success(expense);
    }
    return ExpenseCreateResponse.error();
  }

  Future<ExpenseSaveResponse> updateExpense(ExpenseModel expense) async {
    final res = await _remoteRepo.updateExpense(expense);
    if (res.status) {
      await _localRepo.saveExpense(expense);
      return res;
    } else if (!res.status && res.message == "Network error".tr()) {
      await _localRepo.saveExpense(expense);
      return ExpenseSaveResponse.success();
    }
    return res;
  }

  Future<ExpenseSaveResponse> deleteExpense(ExpenseModel expense) async {
    if (expense.isLocal) {
      await _localRepo.deleteExpense(expense);
      return ExpenseSaveResponse.success();
    } else {
      final res = await _remoteRepo.deleteExpense(expense);
      if (res.status) {
        await _localRepo.deleteExpense(expense);
        return res;
      }
      return res;
    }
  }

  //-- Contributions

  Future<ContributionListResponse> getContributions(
    String qurbaniIdentifier, {
    ValueChanged<List<ContributionModel>?>? onRemoteFetch,
  }) async {
    var res = await _localRepo.getContributions(qurbaniIdentifier);

    if ((res.data ?? []).isEmpty) {
      res = await _remoteRepo.getContributions(qurbaniIdentifier);
      if (res.status) {
        _localRepo.refreshContributions(res.data ?? []);
      }
    } else if (onRemoteFetch != null) {
      try {
        _remoteRepo.getContributions(qurbaniIdentifier).then((e) {
          if (e.status) {
            _localRepo.refreshContributions(e.data ?? []);
          }
          onRemoteFetch.call(e.data);
        });
      } catch (e) {
        onRemoteFetch.call(null);
      }
    }

    return res;
  }

  Future<ContributionCreateResponse> createContribution(
    ContributionModel expense,
  ) async {
    final res = await _remoteRepo.createContribution(expense);
    if (res.status) {
      await _localRepo.saveContribution(res.data!);
      return res;
    } else if (!res.status && res.message == "Network error".tr()) {
      expense.identifier = Utils.genUuid();
      expense.isLocal = true;
      await _localRepo.saveContribution(expense);
      return ContributionCreateResponse.success(expense);
    }
    return ContributionCreateResponse.error();
  }

  Future<ContributionSaveResponse> updateContribution(
    ContributionModel expense,
  ) async {
    final res = await _remoteRepo.updateContribution(expense);
    if (res.status) {
      await _localRepo.saveContribution(expense);
      return res;
    } else if (!res.status && res.message == "Network error".tr()) {
      await _localRepo.saveContribution(expense);
      return ContributionSaveResponse.success();
    }
    return res;
  }

  Future<ContributionSaveResponse> deleteContribution(
    ContributionModel expense,
  ) async {
    if (expense.isLocal) {
      await _localRepo.deleteContribution(expense);
      return ContributionSaveResponse.success();
    } else {
      final res = await _remoteRepo.deleteContribution(expense);
      if (res.status) {
        await _localRepo.deleteContribution(expense);
        return res;
      }
      return res;
    }
  }
}
