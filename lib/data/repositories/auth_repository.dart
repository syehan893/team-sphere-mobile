import 'package:injectable/injectable.dart';

import '../../core/network/network.dart';
import '../datasources/datasources.dart';
import '../models/models.dart';

@injectable
class AuthRepository {
  final SupabaseAuthDatasource _datasource;
  final SessionManager _sessionManager;
  final UserLocalDatasource _userLocalDatasource;
  final AuthService _authService;

  AuthRepository(this._datasource, this._sessionManager, this._authService,
      this._userLocalDatasource);

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
      UserModel user = UserModel.fromSupabaseUser(response.user!);
      await _sessionManager.saveSession(response.session!);
      await _userLocalDatasource.saveUser(user.email);
      return user;
    }
    return null;
  }

  Future<void> signOut() async {
    await _datasource.signOut();
    await _userLocalDatasource.clearUser();
    await _sessionManager.clearSession();
  }

  Future<String?> getAccessToken() async {
    return await _authService.getAccessToken();
  }
}
