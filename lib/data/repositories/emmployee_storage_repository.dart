import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/core/helpers/logger.dart';

import '../data.dart';

@injectable
class EmployeeStorageRepository {
  final SupabaseStorageDatasource _storageDatasource;

  EmployeeStorageRepository(this._storageDatasource);

  Future<String?> getEmployeeAvatarUrl(String email) async {
    try {
      return await _storageDatasource.getPublicUrl('employee_profile', '$email.jpg');
    } catch (e) {
      logger.e('Error getting employee avatar URL: $e');
      return null;
    }
  }

  Future<bool> uploadEmployeeAvatar(String email, Uint8List fileBytes) async {
    try {
      await _storageDatasource.uploadFile('employee', email, fileBytes, contentType: 'image/jpeg');
      return true;
    } catch (e) {
      logger.e('Error uploading employee avatar: $e');
      return false;
    }
  }
}