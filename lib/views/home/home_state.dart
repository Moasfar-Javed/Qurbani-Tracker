part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeReady extends HomeState {
  final bool isLoggedIn;
  final List<QurbaniModel> qurbanis;

  const HomeReady({required this.isLoggedIn, required this.qurbanis});

  @override
  List<Object> get props => [isLoggedIn, qurbanis];
}

final class HomeLoadError extends HomeState {
  final String message;
  const HomeLoadError({required this.message});

  @override
  List<Object> get props => [message];
}
