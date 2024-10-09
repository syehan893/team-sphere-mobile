import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/data.dart';

abstract class LeaveRequestState {}

class LeaveRequestInitial extends LeaveRequestState {}

class LeaveRequestLoading extends LeaveRequestState {}

class LeaveRequestLoaded extends LeaveRequestState {
  final List<LeaveRequest> leaveRequests;

  LeaveRequestLoaded(this.leaveRequests);
}

class LeaveRequestError extends LeaveRequestState {
  final String error;

  LeaveRequestError(this.error);
}

@injectable
class LeaveRequestCubit extends Cubit<LeaveRequestState> {
  final LeaveRequestRepository _repository;

  LeaveRequestCubit(this._repository) : super(LeaveRequestInitial());

  Future<void> fetchLeaveRequestsByEmployeeId(String employeeId) async {
    emit(LeaveRequestLoading());
    try {
      final leaveRequests =
          await _repository.getLeaveRequestsByEmployeeId(employeeId);
      emit(LeaveRequestLoaded(leaveRequests));
    } catch (e) {
      emit(LeaveRequestError(e.toString()));
    }
  }

  Future<void> fetchLeaveRequestsByManagerId(String managerId) async {
    emit(LeaveRequestLoading());
    try {
      final leaveRequests =
          await _repository.getLeaveRequestsByManagerId(managerId);
      emit(LeaveRequestLoaded(leaveRequests));
    } catch (e) {
      emit(LeaveRequestError(e.toString()));
    }
  }

  Future<void> createLeaveRequest(LeaveRequest leaveRequest) async {
    emit(LeaveRequestLoading());
    try {
      await _repository.createLeaveRequest(leaveRequest);
      emit(LeaveRequestInitial());
    } catch (e) {
      emit(LeaveRequestError(e.toString()));
    }
  }

  Future<void> updateLeaveRequest(
      int requestId, Map<String, dynamic> data) async {
    emit(LeaveRequestLoading());
    try {
      await _repository.updateLeaveRequest(requestId, data);
      emit(LeaveRequestInitial());
    } catch (e) {
      emit(LeaveRequestError(e.toString()));
    }
  }
}
