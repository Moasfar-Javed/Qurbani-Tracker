import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'qurbani_state.dart';

class QurbaniCubit extends Cubit<QurbaniState> {
  QurbaniCubit() : super(QurbaniInitial());

  void initialize() async {
    
  }
}
