part of 'qurbani_cubit.dart';

sealed class QurbaniState extends Equatable {
  const QurbaniState();

  @override
  List<Object> get props => [];
}

final class QurbaniInitial extends QurbaniState {}

final class QurbaniLoading extends QurbaniState {}

final class QurbaniReady extends QurbaniState {
  final QurbaniModel qurbani;
  final List<Spending> spendings;
  final List<ExpenseModel> expenses;
  final List<ContributionModel> contributions;

  const QurbaniReady({
    required this.qurbani,
    required this.spendings,
    required this.expenses,
    required this.contributions,
  });

  @override
  List<Object> get props => [qurbani, expenses, contributions];
}

final class QurbaniLoadError extends QurbaniState {
  final String message;

  const QurbaniLoadError({required this.message});

  @override
  List<Object> get props => [message];
}
