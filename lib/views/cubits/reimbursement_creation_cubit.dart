import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/data.dart';

abstract class CreateReimbursementRequestState {}

class CreateReimbursementRequestInitial extends CreateReimbursementRequestState {}

class CreateReimbursementRequestLoading extends CreateReimbursementRequestState {}

class CreateReimbursementRequestSuccess extends CreateReimbursementRequestState {}

class CreateReimbursementRequestError extends CreateReimbursementRequestState {
  final String error;

  CreateReimbursementRequestError(this.error);
}

@injectable
class CreateReimbursementRequestCubit extends Cubit<CreateReimbursementRequestState> {
  final ReimbursementRequestRepository _repository;

  CreateReimbursementRequestCubit(this._repository)
      : super(CreateReimbursementRequestInitial());

  Future<void> createReimbursementRequest(ReimbursementRequest reimbursementRequest) async {
    emit(CreateReimbursementRequestLoading());
    try {
      await _repository.createReimbursementRequest(reimbursementRequest);
      emit(CreateReimbursementRequestSuccess());
    } catch (e) {
      emit(CreateReimbursementRequestError(e.toString()));
    }
  }

  Future<void> updateReimbursementRequest(int requestId, Map<String, dynamic> data) async {
    emit(CreateReimbursementRequestLoading());
    try {
      await _repository.updateReimbursementRequest(requestId, data);
      emit(CreateReimbursementRequestSuccess());
    } catch (e) {
      emit(CreateReimbursementRequestError(e.toString()));
    }
  }
}
