import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/core/enums/creation_status.dart';

import '../../data/data.dart';

class CreateLeaveRequestState {
  final CreationStatus status;
  final CreationStatus updateStatus;
  final LeaveRequest leaveRequest;
  final String? error;

  CreateLeaveRequestState({
    this.status = CreationStatus.initial,
    this.updateStatus = CreationStatus.initial,
    required this.leaveRequest,
    this.error,
  });

  CreateLeaveRequestState copyWith({
    CreationStatus? status,
    CreationStatus? updateStatus,
    LeaveRequest? leaveRequest,
    String? error,
  }) {
    return CreateLeaveRequestState(
      status: status ?? this.status,
      leaveRequest: leaveRequest ?? this.leaveRequest,
      updateStatus: updateStatus ?? this.updateStatus,
      error: error,
    );
  }
}

@injectable
class CreateLeaveRequestCubit extends Cubit<CreateLeaveRequestState> {
  final LeaveRequestRepository _repository;

  CreateLeaveRequestCubit(this._repository)
      : super(CreateLeaveRequestState(
          leaveRequest: LeaveRequest(
            employeeId: '',
            leaveType: 'Annual Leave',
            startDate: DateTime.now(),
            endDate: DateTime.now(),
            totalDays: 0,
            reason: '',
            status: 'Pending',
            managerId: '',
            managerComment: '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            employee: null,
            requestId: 6,
          ),
        ));

  void updateStartDate(DateTime newDate) {
    emit(state.copyWith(
        leaveRequest: state.leaveRequest.copyWith(
      startDate: newDate,
    )));
  }

  void updateEndDate(DateTime newDate) {
    emit(state.copyWith(
        leaveRequest: state.leaveRequest.copyWith(
      endDate: newDate,
      totalDays: newDate.difference(state.leaveRequest.startDate).inDays + 1,
    )));
  }

  void updateLeaveType(String newType) {
    emit(state.copyWith(
        leaveRequest: state.leaveRequest.copyWith(leaveType: newType)));
  }

  void updateReason(String newReason) {
    emit(state.copyWith(
        leaveRequest: state.leaveRequest.copyWith(reason: newReason)));
  }

  void updateEmployeeId(String employeeId) {
    emit(state.copyWith(
        leaveRequest: state.leaveRequest.copyWith(employeeId: employeeId)));
  }

  void updateManagerId(String managerId) {
    emit(state.copyWith(
        leaveRequest: state.leaveRequest.copyWith(managerId: managerId)));
  }

  Future<void> createLeaveRequest() async {
    emit(state.copyWith(status: CreationStatus.loading));
    try {
      await _repository.createLeaveRequest(state.leaveRequest);
      emit(state.copyWith(status: CreationStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CreationStatus.error, error: e.toString()));
    }
  }

  Future<void> updateLeaveRequest(
      LeaveRequest leaveRequest, String status) async {
    emit(state.copyWith(updateStatus: CreationStatus.loading));
    try {
      await _repository
          .updateLeaveRequest(leaveRequest.copyWith(status: status));
      emit(state.copyWith(updateStatus: CreationStatus.success));
    } catch (e) {
      emit(state.copyWith(updateStatus: CreationStatus.error, error: e.toString()));
    }
  }
}
