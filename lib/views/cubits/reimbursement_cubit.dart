import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';
import '../../data/data.dart';

class FetchReimbursementRequestState {
  final FetchStatus employeeFetchStatus;
  final FetchStatus managerFetchStatus;
  final List<ReimbursementRequest>? reimbursementRequests;
  final List<ReimbursementRequest>? approvalReimbursementRequests;
  final String? error;

  FetchReimbursementRequestState({
    this.employeeFetchStatus = FetchStatus.initial,
    this.managerFetchStatus = FetchStatus.initial,
    this.reimbursementRequests,
    this.approvalReimbursementRequests,
    this.error,
  });

  FetchReimbursementRequestState copyWith({
    FetchStatus? employeeFetchStatus,
    FetchStatus? managerFetchStatus,
    List<ReimbursementRequest>? reimbursementRequests,
    List<ReimbursementRequest>? approvalReimbursementRequests,
    String? error,
  }) {
    return FetchReimbursementRequestState(
      employeeFetchStatus: employeeFetchStatus ?? this.employeeFetchStatus,
      managerFetchStatus: managerFetchStatus ?? this.managerFetchStatus,
      reimbursementRequests:
          reimbursementRequests ?? this.reimbursementRequests,
      approvalReimbursementRequests:
          approvalReimbursementRequests ?? this.approvalReimbursementRequests,
      error: error ?? this.error,
    );
  }
}

@injectable
class FetchReimbursementRequestCubit
    extends Cubit<FetchReimbursementRequestState> {
  final ReimbursementRequestRepository _repository;

  FetchReimbursementRequestCubit(this._repository)
      : super(FetchReimbursementRequestState());

  Future<void> fetchReimbursementRequestsByEmployeeId() async {
    emit(state.copyWith(employeeFetchStatus: FetchStatus.loading));
    try {
      final prefs = await SharedPreferences.getInstance();
      final employeeId = prefs.getString('employeeId') ?? '';
      final reimbursementRequests =
          await _repository.getReimbursementRequestsByEmployeeId(employeeId);
      emit(state.copyWith(
        employeeFetchStatus: FetchStatus.loaded,
        reimbursementRequests: reimbursementRequests,
      ));
    } catch (e) {
      emit(state.copyWith(
        employeeFetchStatus: FetchStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> fetchReimbursementRequestsByManagerId() async {
    emit(state.copyWith(managerFetchStatus: FetchStatus.loading));
    try {
      final prefs = await SharedPreferences.getInstance();
      final managerId = prefs.getString('employeeId') ?? '';
      final reimbursementRequests =
          await _repository.getReimbursementRequestsByManagerId(managerId);
      emit(state.copyWith(
        managerFetchStatus: FetchStatus.loaded,
        approvalReimbursementRequests: reimbursementRequests.where((e) => e.status == 'Pending').toList(),
      ));
    } catch (e) {
      emit(state.copyWith(
        managerFetchStatus: FetchStatus.error,
        error: e.toString(),
      ));
    }
  }
}
