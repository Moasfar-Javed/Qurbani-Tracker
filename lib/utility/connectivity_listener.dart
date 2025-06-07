part of 'utility.dart';

class ConnectivityListener {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  void initialize() {
    if (_subscription != null) return;
    _subscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        Future.delayed(Durations.extralong4).then((_) async {
          // TODO: apply sync
        });
      }
    });
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
