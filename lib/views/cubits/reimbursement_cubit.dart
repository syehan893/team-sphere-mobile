import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/data.dart';

abstract class ReimbursementRequestState {}

class ReimbursementRequestInitial extends ReimbursementRequestState {}

class ReimbursementRequestLoading extends ReimbursementRequestState {}

class ReimbursementRequestLoaded extends ReimbursementRequestState {
  final List<ReimbursementRequest> reimbursementRequests;

  ReimbursementRequestLoaded(this.reimbursementRequests);
}

class ReimbursementRequestError extends ReimbursementRequestState {
  final String error;

  ReimbursementRequestError(this.error);
}

@injectable
class ReimbursementRequestCubit extends Cubit<ReimbursementRequestState> {
  final ReimbursementRequestRepository _repository;

  ReimbursementRequestCubit(this._repository)
      : super(ReimbursementRequestInitial());

  Future<void> fetchReimbursementRequestsByEmployeeId(String employeeId) async {
    emit(ReimbursementRequestLoading());
    try {
      final reimbursementRequests =
          await _repository.getReimbursementRequestsByEmployeeId(employeeId);
      emit(ReimbursementRequestLoaded(reimbursementRequests));
    } catch (e) {
      emit(ReimbursementRequestError(e.toString()));
    }
  }

  Future<void> fetchReimbursementRequestsByManagerId(String managerId) async {
    emit(ReimbursementRequestLoading());
    try {
      final reimbursementRequests =
          await _repository.getReimbursementRequestsByManagerId(managerId);
      emit(ReimbursementRequestLoaded(reimbursementRequests));
    } catch (e) {
      emit(ReimbursementRequestError(e.toString()));
    }
  }

  Future<void> createReimbursementRequest(
      ReimbursementRequest reimbursementRequest) async {
    emit(ReimbursementRequestLoading());
    try {
      await _repository.createReimbursementRequest(reimbursementRequest);
      emit(ReimbursementRequestInitial());
    } catch (e) {
      emit(ReimbursementRequestError(e.toString()));
    }
  }

  Future<void> updateReimbursementRequest(
      int requestId, Map<String, dynamic> data) async {
    emit(ReimbursementRequestLoading());
    try {
      await _repository.updateReimbursementRequest(requestId, data);
      emit(ReimbursementRequestInitial());
    } catch (e) {
      emit(ReimbursementRequestError(e.toString()));
    }
  }
}
