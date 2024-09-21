import 'package:injectable/injectable.dart';

import '../../core/network/network.dart';
import '../datasources/datasources.dart';
import '../models/models.dart';

@injectable
class AuthRepository {
  final SupabaseAuthDatasource _datasource;
  final SessionManager _sessionManager;
  final AuthService _authService;

  AuthRepository(this._datasource, this._sessionManager, this._authService);

  Future<UserModel?> signUp(String email, String password) async {
    final response = await _datasource.signUp(email, password);
    if (response.user != null && response.session != null) {
      await _sessionManager.saveSession(response.session!);
      return UserModel.fromSupabaseUser(response.user!);
    }
    return null;
  }

  Future<UserModel?> signIn(String email, String password) async {
    final response = await _datasource.signIn(email, password);
    if (response.user != null && response.session != null) {
      await _sessionManager.saveSession(response.session!);
      return UserModel.fromSupabaseUser(response.user!);
    }
    return null;
  }

  Future<void> signOut() async {
    await _datasource.signOut();
    await _sessionManager.clearSession();
  }

  Future<String?> getAccessToken() async {
    return await _authService.getAccessToken();
  }
}