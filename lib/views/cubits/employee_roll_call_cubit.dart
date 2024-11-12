import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';

import '../../data/data.dart';

class EmployeeRollCallState {
  final FetchStatus status;
  final List<EmployeeRollCall>? rollCalls;
  final String? errorMessage;

  EmployeeRollCallState({
    required this.status,
    this.rollCalls,
    this.errorMessage,
  });
}

@injectable
class EmployeeRollCallCubit extends Cubit<EmployeeRollCallState> {
  final EmployeeRollCallRepository _repository;

  EmployeeRollCallCubit(this._repository)
      : super(EmployeeRollCallState(status: FetchStatus.initial));

  Future<void> getEmployeeRollCallsByDay(String day) async {
    emit(EmployeeRollCallState(status: FetchStatus.loading));
    try {
      final rollCalls = await _repository.getEmployeeRollCallsByDay(day);
      if (rollCalls.isNotEmpty) {
        emit(EmployeeRollCallState(
            status: FetchStatus.loaded, rollCalls: rollCalls));
      } else {
        emit(EmployeeRollCallState(status: FetchStatus.loaded, rollCalls: []));
      }
    } catch (e) {
      emit(EmployeeRollCallState(
        status: FetchStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
