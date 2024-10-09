import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/data.dart';

abstract class EmployeeRollCallState {}

class EmployeeRollCallInitial extends EmployeeRollCallState {}

class EmployeeRollCallLoading extends EmployeeRollCallState {}

class EmployeeRollCallLoaded extends EmployeeRollCallState {
  final List<EmployeeRollCall> rollCalls;

  EmployeeRollCallLoaded(this.rollCalls);
}

class EmployeeRollCallError extends EmployeeRollCallState {
  final String error;

  EmployeeRollCallError(this.error);
}

@injectable
class EmployeeRollCallCubit extends Cubit<EmployeeRollCallState> {
  final EmployeeRollCallRepository _repository;

  EmployeeRollCallCubit(this._repository) : super(EmployeeRollCallInitial());

  Future<void> fetchEmployeeRollCallsByDay(String day) async {
    emit(EmployeeRollCallLoading());
    try {
      final rollCalls = await _repository.getEmployeeRollCallsByDay(day);
      emit(EmployeeRollCallLoaded(rollCalls));
    } catch (e) {
      emit(EmployeeRollCallError(e.toString()));
    }
  }
}
