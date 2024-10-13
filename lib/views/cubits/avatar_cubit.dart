import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/data.dart';

@injectable
class EmployeeAvatarCubit extends Cubit<String?> {
  final EmployeeStorageRepository _storageRepository;

  EmployeeAvatarCubit(this._storageRepository) : super(null);

  Future<void> loadAvatar(String email) async {
    final avatarUrl = await _storageRepository.getEmployeeAvatarUrl(email);
    emit(avatarUrl);
  }
}