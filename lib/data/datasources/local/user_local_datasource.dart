import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class UserLocalDatasource {
  static const String _userKey = 'user';

  Future<void> saveUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, email);
  }

  Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey);
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}