import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';
import '../../data/data.dart';

class FetchLeaveRequestState {
  final FetchStatus employeeFetchStatus;
  final FetchStatus managerFetchStatus;
  final List<LeaveRequest>? leaveRequests;
  final List<LeaveRequest>? approvalLeaveRequests;
  final String? error;

  FetchLeaveRequestState({
    this.employeeFetchStatus = FetchStatus.initial,
    this.managerFetchStatus = FetchStatus.initial,
    this.leaveRequests,
    this.approvalLeaveRequests,
    this.error,
  });

  FetchLeaveRequestState copyWith({
    FetchStatus? employeeFetchStatus,
    FetchStatus? managerFetchStatus,
    List<LeaveRequest>? leaveRequests,
    List<LeaveRequest>? approvalLeaveRequests,
    String? error,
  }) {
    return FetchLeaveRequestState(
      employeeFetchStatus: employeeFetchStatus ?? this.employeeFetchStatus,
      managerFetchStatus: managerFetchStatus ?? this.managerFetchStatus,
      leaveRequests: leaveRequests ?? this.leaveRequests,
      approvalLeaveRequests:
          approvalLeaveRequests ?? this.approvalLeaveRequests,
      error: error ?? this.error,
    );
  }
}

@injectable
class FetchLeaveRequestCubit extends Cubit<FetchLeaveRequestState> {
  final LeaveRequestRepository _repository;

  FetchLeaveRequestCubit(this._repository) : super(FetchLeaveRequestState());

  Future<void> fetchLeaveRequestsByEmployeeId() async {
    emit(state.copyWith(employeeFetchStatus: FetchStatus.loading));
    try {
      final prefs = await SharedPreferences.getInstance();
      final employeeId = prefs.getString('employeeId') ?? '';
      final leaveRequests =
          await _repository.getLeaveRequestsByEmployeeId(employeeId);
      emit(state.copyWith(
        employeeFetchStatus: FetchStatus.loaded,
        leaveRequests: leaveRequests,
      ));
    } catch (e) {
      emit(state.copyWith(
        employeeFetchStatus: FetchStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> fetchLeaveRequestsByManagerId() async {
    emit(state.copyWith(managerFetchStatus: FetchStatus.loading));
    try {
      final prefs = await SharedPreferences.getInstance();
      final managerId = prefs.getString('employeeId') ?? '';
      final leaveRequests =
          await _repository.getLeaveRequestsByManagerId(managerId);
      emit(state.copyWith(
        managerFetchStatus: FetchStatus.loaded,
        approvalLeaveRequests:
            leaveRequests.where((e) => e.status == 'Pending').toList(),
      ));
    } catch (e) {
      emit(state.copyWith(
        managerFetchStatus: FetchStatus.error,
        error: e.toString(),
      ));
    }
  }
}
