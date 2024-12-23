// /lib/cubit/employee_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data.dart';

abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final Employee employee;

  EmployeeLoaded(this.employee);
}

class EmployeeError extends EmployeeState {
  final String error;

  EmployeeError(this.error);
}

@injectable
class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository _repository;

  EmployeeCubit(this._repository) : super(EmployeeInitial());

  Future<void> fetchEmployeeByEmail() async {
    emit(EmployeeLoading());
    try {
      final employee = await _repository.getEmployeeByEmail();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('employeeId', employee.employeeId);
      await prefs.setString('managerId', employee.managerId ?? '');
      emit(EmployeeLoaded(employee));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }
}
