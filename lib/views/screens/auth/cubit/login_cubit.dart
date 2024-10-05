import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/core/exceptions/auth_exception.dart';
import 'package:team_sphere_mobile/data/data.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final UserModel? user;
  final AuthException? error;

  AuthState({required this.status, this.user, this.error});
}

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository)
      : super(AuthState(status: AuthStatus.initial)) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    emit(AuthState(status: AuthStatus.loading));
    final token = await _authRepository.getAccessToken();
    if (token != null) {
      emit(AuthState(status: AuthStatus.authenticated));
    } else {
      emit(AuthState(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthState(status: AuthStatus.loading));

    try {
      final user = await _authRepository.signUp(email, password);
      if (user != null) {
        emit(AuthState(status: AuthStatus.authenticated, user: user));
      } else {
        emit(AuthState(
            status: AuthStatus.unauthenticated,
            error: AuthException(message: 'Sign Up Failed')));
      }
    } catch (e) {
      emit(AuthState(
          status: AuthStatus.unauthenticated,
          error: AuthException(message: e.toString())));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthState(status: AuthStatus.loading));

    try {
      final user = await _authRepository.signIn(email, password);
      if (user != null) {
        emit(AuthState(status: AuthStatus.authenticated, user: user));
      } else {
        emit(AuthState(
            status: AuthStatus.unauthenticated,
            error: AuthException(message: 'Sign In Failed')));
      }
    } catch (e) {
      emit(AuthState(
          status: AuthStatus.unauthenticated,
          error: AuthException(message: e.toString())));
    }
  }

  Future<void> signOut() async {
    emit(AuthState(status: AuthStatus.loading));
    await _authRepository.signOut();
    emit(AuthState(status: AuthStatus.unauthenticated));
  }
}
