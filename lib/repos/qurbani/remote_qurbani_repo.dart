part of '../repos.dart';

class RemoteQurbaniRepo {
  RemoteQurbaniRepo._privateConstructor();
  static final RemoteQurbaniRepo _instance =
      RemoteQurbaniRepo._privateConstructor();
  factory RemoteQurbaniRepo() {
    return _instance;
  }

  //-- Qurbani

  Future<QurbaniCreateResponse> createQurbani(QurbaniModel qurbani) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw UserNotAuthenticatedEx();
      }

      final collectionRef = FirebaseFirestore.instance
          .collection(Keys.k_Users)
          .doc(user.uid)
          .collection(Keys.dbQurbanisTable);

      final docRef = collectionRef.doc();
      await docRef.set(qurbani.toJson());

      qurbani.identifier = docRef.id;

      return QurbaniCreateResponse.success(qurbani);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-error') {
        return QurbaniCreateResponse.networkError();
      }
    } catch (e) {
      return QurbaniCreateResponse.error();
    }
    return QurbaniCreateResponse.error();
  }

  Future<QurbaniSaveResponse> updateQurbani(QurbaniModel qurbani) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw UserNotAuthenticatedEx();
      }

      final docRef = FirebaseFirestore.instance
          .collection(Keys.k_Users)
          .doc(user.uid)
          .collection(Keys.dbQurbanisTable)
          .doc(qurbani.identifier.toString());

      final jsonData = qurbani.toJson();

      await docRef.set(jsonData, SetOptions(merge: true));
      return QurbaniSaveResponse.success();
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-error') {
        return QurbaniSaveResponse.networkError();
      }
    } catch (e) {
      return QurbaniSaveResponse.error();
    }
    return QurbaniSaveResponse.error();
  }

  Future<QurbaniListResponse> getQurbanis() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw UserNotAuthenticatedEx();
      }

      final querySnapshot = await FirebaseFirestore.instance
          .collection(Keys.k_Users)
          .doc(user.uid)
          .collection(Keys.dbQurbanisTable)
          .orderBy(Keys.dbUpdatedOn, descending: true)
          .orderBy('onGoing', descending: false)
          .get();

      return QurbaniListResponse.success(
        querySnapshot.docs.map((e) => (e.data(), e.id)).toList(),
      );
    } on FirebaseException catch (e) {
      print(e);
      if (e.code == 'unavailable' || e.code == 'network-error') {
        return QurbaniListResponse.networkError();
      }
    } catch (e) {
      print(e);
      return QurbaniListResponse.error();
    }
    return QurbaniListResponse.error();
  }

  //-- Expenses

  Future<ExpenseCreateResponse> createExpense(ExpenseModel expense) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw UserNotAuthenticatedEx();
      }

      final collectionRef = FirebaseFirestore.instance
          .collection(Keys.k_Users)
          .doc(user.uid)
          .collection(Keys.dbQurbanisTable)
          .doc(expense.qurbaniIdentifier)
          .collection(Keys.dbExpensesTable);

      final docRef = collectionRef.doc();
      await docRef.set(expense.toJson());

      expense.identifier = docRef.id;

      return ExpenseCreateResponse.success(expense);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-error') {
        return ExpenseCreateResponse.networkError();
      }
    } catch (e) {
      return ExpenseCreateResponse.error();
    }
    return ExpenseCreateResponse.error();
  }

  Future<ExpenseSaveResponse> updateExpense(ExpenseModel expense) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw UserNotAuthenticatedEx();
      }

      final docRef = FirebaseFirestore.instance
          .collection(Keys.k_Users)
          .doc(user.uid)
          .collection(Keys.dbQurbanisTable)
          .doc(expense.qurbaniIdentifier)
          .collection(Keys.dbExpensesTable)
          .doc(expense.identifier);

      final jsonData = expense.toJson();

      await docRef.set(jsonData, SetOptions(merge: true));
      return ExpenseSaveResponse.success();
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-error') {
        return ExpenseSaveResponse.networkError();
      }
    } catch (e) {
      return ExpenseSaveResponse.error();
    }
    return ExpenseSaveResponse.error();
  }

  Future<ExpenseSaveResponse> deleteExpense(ExpenseModel expense) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw UserNotAuthenticatedEx();
      }

      final docRef = FirebaseFirestore.instance
          .collection(Keys.k_Users)
          .doc(user.uid)
          .collection(Keys.dbQurbanisTable)
          .doc(expense.qurbaniIdentifier)
          .collection(Keys.dbExpensesTable)
          .doc(expense.identifier);

      await docRef.delete();
      return ExpenseSaveResponse.success();
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-error') {
        return ExpenseSaveResponse.networkError();
      }
    } catch (e) {
      return ExpenseSaveResponse.error();
    }
    return ExpenseSaveResponse.error();
  }

  Future<ExpenseListResponse> getExpenses(String qurbaniIdentifier) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw UserNotAuthenticatedEx();
      }

      final querySnapshot = await FirebaseFirestore.instance
          .collection(Keys.k_Users)
          .doc(user.uid)
          .collection(Keys.dbQurbanisTable)
          .doc(qurbaniIdentifier)
          .collection(Keys.dbExpensesTable)
          .orderBy(Keys.dbCreatedOn, descending: true)
          .get();

      return ExpenseListResponse.success(
        querySnapshot.docs
            .map((e) => (e.data(), e.id, qurbaniIdentifier))
            .toList(),
      );
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-error') {
        return ExpenseListResponse.networkError();
      }
    } catch (e) {
      return ExpenseListResponse.error();
    }
    return ExpenseListResponse.error();
  }

  //-- Contributions

  Future<ContributionCreateResponse> createContribution(
    ContributionModel contribution,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw UserNotAuthenticatedEx();
      }

      final collectionRef = FirebaseFirestore.instance
          .collection(Keys.k_Users)
          .doc(user.uid)
          .collection(Keys.dbQurbanisTable)
          .doc(contribution.qurbaniIdentifier)
          .collection(Keys.dbContributionsTable);

      final docRef = collectionRef.doc();
      await docRef.set(contribution.toJson());

      contribution.identifier = docRef.id;

      return ContributionCreateResponse.success(contribution);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-error') {
        return ContributionCreateResponse.networkError();
      }
    } catch (e) {
      return ContributionCreateResponse.error();
    }
    return ContributionCreateResponse.error();
  }

  Future<ContributionSaveResponse> updateContribution(
    ContributionModel contribution,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw UserNotAuthenticatedEx();
      }

      final docRef = FirebaseFirestore.instance
          .collection(Keys.k_Users)
          .doc(user.uid)
          .collection(Keys.dbQurbanisTable)
          .doc(contribution.qurbaniIdentifier)
          .collection(Keys.dbContributionsTable)
          .doc(contribution.identifier);

      final jsonData = contribution.toJson();

      await docRef.set(jsonData, SetOptions(merge: true));
      return ContributionSaveResponse.success();
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-error') {
        return ContributionSaveResponse.networkError();
      }
    } catch (e) {
      return ContributionSaveResponse.error();
    }
    return ContributionSaveResponse.error();
  }

  Future<ContributionSaveResponse> deleteContribution(
    ContributionModel contribution,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw UserNotAuthenticatedEx();
      }

      final docRef = FirebaseFirestore.instance
          .collection(Keys.k_Users)
          .doc(user.uid)
          .collection(Keys.dbQurbanisTable)
          .doc(contribution.qurbaniIdentifier)
          .collection(Keys.dbContributionsTable)
          .doc(contribution.identifier);

      await docRef.delete();
      return ContributionSaveResponse.success();
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-error') {
        return ContributionSaveResponse.networkError();
      }
    } catch (e) {
      return ContributionSaveResponse.error();
    }
    return ContributionSaveResponse.error();
  }

  Future<ContributionListResponse> getContributions(
    String qurbaniIdentifier,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw UserNotAuthenticatedEx();
      }

      final querySnapshot = await FirebaseFirestore.instance
          .collection(Keys.k_Users)
          .doc(user.uid)
          .collection(Keys.dbQurbanisTable)
          .doc(qurbaniIdentifier)
          .collection(Keys.dbContributionsTable)
          .orderBy(Keys.dbCreatedOn, descending: true)
          .get();

      return ContributionListResponse.success(
        querySnapshot.docs
            .map((e) => (e.data(), e.id, qurbaniIdentifier))
            .toList(),
      );
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-error') {
        return ContributionListResponse.networkError();
      }
    } catch (e) {
      return ContributionListResponse.error();
    }
    return ContributionListResponse.error();
  }
}
