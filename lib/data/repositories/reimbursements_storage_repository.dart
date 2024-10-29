import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/core/helpers/logger.dart';

import '../data.dart';

@injectable
class ReimbursementStorageRepository {
  final SupabaseStorageDatasource _storageDatasource;

  ReimbursementStorageRepository(this._storageDatasource);

  Future<String?> getReimbursementUrl(String path) async {
    try {
      return await _storageDatasource.getPublicUrl('reimbursement', path);
    } catch (e) {
      logger.e('Error getting employee avatar URL: $e');
      return null;
    }
  }

  Future<bool> uploadReimbursement(
      String employeeId, String fileName, Uint8List fileBytes) async {
    try {
      final filePath = '$employeeId/$fileName';
      
      String contentType;
      if (fileName.toLowerCase().endsWith('.png')) {
        contentType = 'image/png';
      } else if (fileName.toLowerCase().endsWith('.pdf')) {
        contentType = 'application/pdf';
      } else {
        contentType = 'image/jpeg';
      }

      await _storageDatasource.uploadFile(
        'reimbursement',
        filePath,
        fileBytes,
        contentType: contentType,
      );
      return true;
    } catch (e) {
      logger.e('Error uploading reimbursement file: $e');
      return false;
    }
  }
}
