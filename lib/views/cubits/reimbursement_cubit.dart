import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/data.dart';

abstract class FetchReimbursementRequestState {}

class FetchReimbursementRequestInitial extends FetchReimbursementRequestState {}

class FetchReimbursementRequestLoading extends FetchReimbursementRequestState {}

class FetchReimbursementRequestLoaded extends FetchReimbursementRequestState {
  final List<ReimbursementRequest> reimbursementRequests;

  FetchReimbursementRequestLoaded(this.reimbursementRequests);
}

class FetchManagerReimbursementRequestLoaded
    extends FetchReimbursementRequestState {
  final List<ReimbursementRequest> approvalReimbursementRequests;

  FetchManagerReimbursementRequestLoaded(this.approvalReimbursementRequests);
}

class FetchReimbursementRequestError extends FetchReimbursementRequestState {
  final String error;

  FetchReimbursementRequestError(this.error);
}

@injectable
class FetchReimbursementRequestCubit
    extends Cubit<FetchReimbursementRequestState> {
  final ReimbursementRequestRepository _repository;

  FetchReimbursementRequestCubit(this._repository)
      : super(FetchReimbursementRequestInitial());

  Future<void> fetchReimbursementRequestsByEmployeeId(String employeeId) async {
    emit(FetchReimbursementRequestLoading());
    try {
      final reimbursementRequests =
          await _repository.getReimbursementRequestsByEmployeeId(employeeId);
      emit(FetchReimbursementRequestLoaded(reimbursementRequests));
    } catch (e) {
      emit(FetchReimbursementRequestError(e.toString()));
    }
  }

  Future<void> fetchReimbursementRequestsByManagerId(String employeeId) async {
    emit(FetchReimbursementRequestLoading());
    try {
      final reimbursementRequests =
          await _repository.getReimbursementRequestsByManagerId(employeeId);
      emit(FetchManagerReimbursementRequestLoaded(reimbursementRequests));
    } catch (e) {
      emit(FetchReimbursementRequestError(e.toString()));
    }
  }
}
