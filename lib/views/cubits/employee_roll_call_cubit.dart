// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:team_sphere_mobile/core/enums/creation_status.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';

import '../../data/data.dart';

class EmployeeRollCallState {
  final FetchStatus? status;
  final CreationStatus? creationStatus;
  final List<EmployeeRollCall>? rollCalls;
  final String? errorMessage;
  final String? error;

  EmployeeRollCallState({
    this.status,
    this.creationStatus,
    this.rollCalls,
    this.errorMessage,
    this.error,
  });

  EmployeeRollCallState copyWith({
    FetchStatus? status,
    CreationStatus? creationStatus,
    List<EmployeeRollCall>? rollCalls,
    String? errorMessage,
    String? error,
  }) {
    return EmployeeRollCallState(
      status: status ?? this.status,
      creationStatus: creationStatus ?? this.creationStatus,
      rollCalls: rollCalls ?? this.rollCalls,
      errorMessage: errorMessage ?? this.errorMessage,
      error: error ?? this.error,
    );
  }
}

@injectable
class EmployeeRollCallCubit extends Cubit<EmployeeRollCallState> {
  final EmployeeRollCallRepository _repository;

  EmployeeRollCallCubit(this._repository) : super(EmployeeRollCallState());

  Future<void> getEmployeeRollCallsByDay(String day) async {
    emit(state.copyWith(status: FetchStatus.loading));
    try {
      final rollCalls = await _repository.getEmployeeRollCallsByDay(day);
      if (rollCalls.isNotEmpty) {
        emit(state.copyWith(status: FetchStatus.loaded, rollCalls: rollCalls));
      } else {
        emit(state.copyWith(status: FetchStatus.loaded, rollCalls: []));
      }
    } catch (e) {
      emit(state.copyWith(
        status: FetchStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> saveRollCall(EmployeeRollCall request) async {
    emit(state.copyWith(creationStatus: CreationStatus.loading));
    try {
      await _repository.saveRollCall(request);
      emit(state.copyWith(creationStatus: CreationStatus.success));
    } catch (e) {
      emit(state.copyWith(
          creationStatus: CreationStatus.error, error: e.toString()));
    }
  }
}
