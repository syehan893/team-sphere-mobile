import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@injectable
class SupabaseAuthDatasource {
  final SupabaseClient _supabaseClient;

  SupabaseAuthDatasource(this._supabaseClient);

  Future<AuthResponse> signUp(String email, String password) async {
    return await _supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signIn(String email, String password) async {
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }
  
}