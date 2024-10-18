import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/data.dart';

abstract class FetchLeaveRequestState {}

class FetchLeaveRequestInitial extends FetchLeaveRequestState {}

class FetchLeaveRequestLoading extends FetchLeaveRequestState {}

class FetchLeaveRequestLoaded extends FetchLeaveRequestState {
  final List<LeaveRequest> leaveRequests;

  FetchLeaveRequestLoaded(this.leaveRequests);
}

class FetchManagerLeaveRequestLoaded extends FetchLeaveRequestState {
  final List<LeaveRequest> approvalLeaveRequests;

  FetchManagerLeaveRequestLoaded(this.approvalLeaveRequests);
}

class FetchLeaveRequestError extends FetchLeaveRequestState {
  final String error;

  FetchLeaveRequestError(this.error);
}

@injectable
class FetchLeaveRequestCubit extends Cubit<FetchLeaveRequestState> {
  final LeaveRequestRepository _repository;

  FetchLeaveRequestCubit(this._repository) : super(FetchLeaveRequestInitial());

  Future<void> fetchLeaveRequestsByEmployeeId(String employeeId) async {
    emit(FetchLeaveRequestLoading());
    try {
      final leaveRequests = await _repository.getLeaveRequestsByEmployeeId(employeeId);
      emit(FetchLeaveRequestLoaded(leaveRequests));
    } catch (e) {
      emit(FetchLeaveRequestError(e.toString()));
    }
  }

  Future<void> fetchLeaveRequestsByManagerId(String employeeId) async {
    emit(FetchLeaveRequestLoading());
    try {
      final leaveRequests = await _repository.getLeaveRequestsByManagerId(employeeId);
      emit(FetchManagerLeaveRequestLoaded(leaveRequests));
    } catch (e) {
      emit(FetchLeaveRequestError(e.toString()));
    }
  }
}
