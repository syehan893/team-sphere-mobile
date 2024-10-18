import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/data.dart';

abstract class CreateLeaveRequestState {}

class CreateLeaveRequestInitial extends CreateLeaveRequestState {}

class CreateLeaveRequestLoading extends CreateLeaveRequestState {}

class CreateLeaveRequestSuccess extends CreateLeaveRequestState {}

class CreateLeaveRequestError extends CreateLeaveRequestState {
  final String error;

  CreateLeaveRequestError(this.error);
}

@injectable
class CreateLeaveRequestCubit extends Cubit<CreateLeaveRequestState> {
  final LeaveRequestRepository _repository;

  CreateLeaveRequestCubit(this._repository) : super(CreateLeaveRequestInitial());

  Future<void> createLeaveRequest(LeaveRequest leaveRequest) async {
    emit(CreateLeaveRequestLoading());
    try {
      await _repository.createLeaveRequest(leaveRequest);
      emit(CreateLeaveRequestSuccess());
    } catch (e) {
      emit(CreateLeaveRequestError(e.toString()));
    }
  }

  Future<void> updateLeaveRequest(int requestId, Map<String, dynamic> data) async {
    emit(CreateLeaveRequestLoading());
    try {
      await _repository.updateLeaveRequest(requestId, data);
      emit(CreateLeaveRequestSuccess());
    } catch (e) {
      emit(CreateLeaveRequestError(e.toString()));
    }
  }
}
