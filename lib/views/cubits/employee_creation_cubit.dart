import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/core/enums/creation_status.dart';

import '../../data/data.dart';

class UpdateEmployeeState extends Equatable {
  final Employee? employee;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? avatarUrl;
  final Uint8List? avatarFileBytes;
  final CreationStatus? status;
  final String? error;

  const UpdateEmployeeState({
    this.employee,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.avatarUrl,
    this.avatarFileBytes,
    this.status = CreationStatus.initial,
    this.error,
  });

  UpdateEmployeeState copyWith({
    Employee? employee,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? avatarUrl,
    Uint8List? avatarFileBytes,
    CreationStatus? status,
    String? error,
  }) {
    return UpdateEmployeeState(
      employee: employee ?? this.employee,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      avatarFileBytes: avatarFileBytes ?? this.avatarFileBytes,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        employee,
        firstName,
        lastName,
        phoneNumber,
        avatarUrl,
        avatarFileBytes,
        status,
        error,
      ];
}

@injectable
class UpdateEmployeeCubit extends Cubit<UpdateEmployeeState> {
  final EmployeeRepository employeeRepository;
  final EmployeeStorageRepository storageRepository;

  UpdateEmployeeCubit(
     this.employeeRepository,
     this.storageRepository,
  ) : super(const UpdateEmployeeState());

  void updateEmployee(Employee employee) {
    emit(state.copyWith(
      employee: employee,
      firstName: employee.firstName,
      lastName: employee.lastName,
      phoneNumber: employee.phoneNumber,
    ));
  }

  void updateFirstName(String firstName) {
    emit(state.copyWith(firstName: firstName));
  }

  void updateLastName(String lastName) {
    emit(state.copyWith(lastName: lastName));
  }

  void updatePhoneNumber(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  Future<void> loadAvatarUrl() async {
    try {
      final url = await storageRepository
          .getEmployeeAvatarUrl(state.employee?.email ?? '');
      emit(state.copyWith(avatarUrl: url));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to load avatar URL'));
    }
  }

  Future<void> pickAvatar() async {
    try {
      final imagePicker = ImagePicker();
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final fileBytes = await pickedFile.readAsBytes();
        emit(state.copyWith(avatarFileBytes: fileBytes));
      }
    } catch (e) {
      emit(state.copyWith(error: 'Failed to pick avatar image'));
    }
  }

  Future<void> saveChanges() async {
    emit(state.copyWith(status: CreationStatus.loading));

    try {
      if (state.avatarFileBytes != null) {
        await storageRepository.deleteEmployeeAvatar(state.employee?.email ?? '');
        final success = await storageRepository.uploadEmployeeAvatar(
          state.employee?.email ?? '',
          state.avatarFileBytes!,
        );
        if (!success) {
          throw Exception('Failed to upload avatar');
        }
      }

      final updatedEmployee = state.employee?.copyWith(
        firstName: state.firstName,
        lastName: state.lastName,
        phoneNumber: state.phoneNumber,
      );
      await employeeRepository.updateEmployee(updatedEmployee!);

      emit(state.copyWith(
        status: CreationStatus.success,
        employee: updatedEmployee,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CreationStatus.error,
        error: e.toString(),
      ));
    }
  }
}
