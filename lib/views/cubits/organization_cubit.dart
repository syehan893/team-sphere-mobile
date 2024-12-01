import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/data.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';

class DepartmentState extends Equatable {
  final FetchStatus? status;
  final List<Organization>? departments;
  final String? errorMessage;

  const DepartmentState({
    this.status,
    this.departments,
    this.errorMessage,
  });

  DepartmentState copyWith({
    FetchStatus? status,
    List<Organization>? departments,
    String? errorMessage,
  }) {
    return DepartmentState(
      status: status ?? this.status,
      departments: departments ?? this.departments,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, departments, errorMessage];
}

@injectable
class DepartmentCubit extends Cubit<DepartmentState> {
  final OrganizationRepository _repository;

  DepartmentCubit(this._repository) : super(const DepartmentState());

  Future<void> getDepartments() async {
    emit(state.copyWith(status: FetchStatus.loading));
    try {
      final departments = await _repository.getDepartments();
      emit(state.copyWith(
        status: FetchStatus.loaded,
        departments: departments,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FetchStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
