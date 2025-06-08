import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qurbani_tracker/models/models.dart';
import 'package:qurbani_tracker/repos/repos.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final QurbaniRepo _qurbaniRepo = QurbaniRepo();

  void initialize() async {
    emit(HomeLoading());
    final res = await _qurbaniRepo.getQurbanis(
      onRemoteFetch: (value) {
        if (value != null) {
          emit(
            HomeReady(
              isLoggedIn:
                  !(FirebaseAuth.instance.currentUser?.isAnonymous ?? true),
              qurbanis: value,
            ),
          );
        }
      },
    );

    if (res.status) {
      emit(
        HomeReady(
          isLoggedIn: !(FirebaseAuth.instance.currentUser?.isAnonymous ?? true),
          qurbanis: res.data ?? [],
        ),
      );
    } else {
      emit(HomeLoadError(message: res.message ?? ""));
    }
  }

  Future<ApiCallResponse<QurbaniModel>> createQurbani() async {
    final res = await _qurbaniRepo.createQurbani(
      QurbaniModel(
        identifier: "new",
        title: "Untitled Qurbani",
        currency: "PKR",
        includeTimestamps: true,
        onGoing: true,
        createdOn: DateTime.now(),
        updatedOn: DateTime.now(),
        shareholders: [],
      ),
    );

    _qurbaniRepo.getQurbanis(
      onRemoteFetch: (value) {
        if (value != null) {
          emit(
            HomeReady(
              isLoggedIn:
                  !(FirebaseAuth.instance.currentUser?.isAnonymous ?? true),
              qurbanis: value,
            ),
          );
        }
      },
    );

    return ApiCallResponse.withResult(res.status, res.message, res.data);
  }

  void reload() => initialize();
}
