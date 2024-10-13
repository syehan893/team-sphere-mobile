import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@injectable
class SupabaseStorageDatasource {
  final SupabaseClient _supabaseClient;

  SupabaseStorageDatasource(this._supabaseClient);

  Future<String> uploadFile(String bucketName, String path, Uint8List fileBytes,
      {String? contentType}) async {
    final response = await _supabaseClient.storage
        .from(bucketName)
        .uploadBinary(path, fileBytes,
            fileOptions: FileOptions(contentType: contentType));
    return response;
  }

  Future<Uint8List> downloadFile(String bucketName, String path) async {
    final response =
        await _supabaseClient.storage.from(bucketName).download(path);
    return response;
  }

  Future<List<FileObject>> listFiles(String bucketName, {String? path}) async {
    final response =
        await _supabaseClient.storage.from(bucketName).list(path: path);
    return response;
  }

  Future<void> deleteFile(String bucketName, List<String> paths) async {
    await _supabaseClient.storage.from(bucketName).remove(paths);
  }

  Future<String> getPublicUrl(String bucketName, String path) async {
    final response = _supabaseClient.storage.from(bucketName).getPublicUrl(path);
    return response;
  }

  Future<void> createBucket(String bucketName) async {
    await _supabaseClient.storage.createBucket(bucketName);
  }

  Future<void> deleteBucket(String bucketName) async {
    await _supabaseClient.storage.deleteBucket(bucketName);
  }
}
