import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/core/constant/strings.dart';

import '../../data/data.dart';

@injectable
class EmployeeAvatarCubit extends Cubit<EmployeeAvatarState> {
  final EmployeeStorageRepository _storageRepository;

  EmployeeAvatarCubit(this._storageRepository) : super(EmployeeAvatarInitial());

  Future<void> loadAvatar(String email) async {
    emit(EmployeeAvatarLoading());
    try {
      final avatarUrl = await _storageRepository.getEmployeeAvatarUrl(email);
      emit(EmployeeAvatarLoaded(avatarUrl ?? CommonStrings.emptyString));
    } catch (e) {
      emit(EmployeeAvatarError('Failed to load avatar'));
    }
  }
}

abstract class EmployeeAvatarState {}

class EmployeeAvatarInitial extends EmployeeAvatarState {}

class EmployeeAvatarLoading extends EmployeeAvatarState {}

class EmployeeAvatarLoaded extends EmployeeAvatarState {
  final String avatarUrl;

  EmployeeAvatarLoaded(this.avatarUrl);
}

class EmployeeAvatarError extends EmployeeAvatarState {
  final String message;

  EmployeeAvatarError(this.message);
}
