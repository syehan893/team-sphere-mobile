import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/datasources/datasources.dart';

@singleton
class AuthService {
  final SupabaseClient _supabaseClient;
  final SessionManager _sessionManager;

  AuthService(this._supabaseClient, this._sessionManager);

  Future<String?> getAccessToken() async {
    final session = _supabaseClient.auth.currentSession;
    if (session == null) {
      return null;
    }

    if (session.isExpired) {
      try {
        final updatedSession = await _supabaseClient.auth.refreshSession();
        if (updatedSession.session != null) {
          await _sessionManager.saveSession(updatedSession.session!);
          return updatedSession.session!.accessToken;
        }
      } catch (e) {
        // ignore: avoid_print
        print('Failed to refresh token: $e');
        await _sessionManager.clearSession();
        return null;
      }
    }

    return session.accessToken;
  }
}