import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:qurbani_tracker/models/models.dart';
import 'package:qurbani_tracker/repos/repos.dart';

part 'qurbani_state.dart';

class QurbaniCubit extends Cubit<QurbaniState> {
  QurbaniCubit(this.originalQurbani) : super(QurbaniInitial());

  final QurbaniRepo _qurbaniRepo = QurbaniRepo();
  final QurbaniModel originalQurbani;

  void initialize() async {
    emit(QurbaniLoading());
    final tasks = await Future.wait([
      _qurbaniRepo.getContributions(originalQurbani.identifier),
      _qurbaniRepo.getExpenses(originalQurbani.identifier),
    ]);

    if (tasks.any((e) => !e.status)) {
      emit(
        QurbaniLoadError(
          message: "There was an error while loading qurbani data".tr(),
        ),
      );
      return;
    }

    final contributionsRes = tasks[0] as ContributionListResponse;
    final expensesRes = tasks[1] as ExpenseListResponse;
    final expenses = expensesRes.data ?? [];
    final contributions = contributionsRes.data ?? [];

    emit(
      QurbaniReady(
        qurbani: originalQurbani,
        spendings: _getSpendings(expenses, contributions),
        expenses: expenses,
        contributions: contributions,
      ),
    );
  }

  void reload() => initialize();

  List<Spending> _getSpendings(
    List<ExpenseModel> expenses,
    List<ContributionModel> contributions,
  ) {
    final allSpendings = <Spending>[...expenses, ...contributions];

    allSpendings.sort((a, b) => b.createdOn.compareTo(a.createdOn));

    return allSpendings;
  }
}
