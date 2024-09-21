import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/data/data.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final UserModel? user;
  final String? error;

  AuthState({required this.status, this.user, this.error});
}

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthState(status: AuthStatus.initial)) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    final token = await _authRepository.getAccessToken();
    if (token != null) {
      emit(AuthState(status: AuthStatus.authenticated));
    } else {
      emit(AuthState(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      final user = await _authRepository.signUp(email, password);
      if (user != null) {
        emit(AuthState(status: AuthStatus.authenticated, user: user));
      } else {
        emit(AuthState(status: AuthStatus.unauthenticated, error: 'Sign up failed'));
      }
    } catch (e) {
      emit(AuthState(status: AuthStatus.unauthenticated, error: e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final user = await _authRepository.signIn(email, password);
      if (user != null) {
        emit(AuthState(status: AuthStatus.authenticated, user: user));
      } else {
        emit(AuthState(status: AuthStatus.unauthenticated, error: 'Sign in failed'));
      }
    } catch (e) {
      emit(AuthState(status: AuthStatus.unauthenticated, error: e.toString()));
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(AuthState(status: AuthStatus.unauthenticated));
  }
}