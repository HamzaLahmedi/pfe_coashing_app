import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _tokenKey = 'jwt_token';
  static SharedPreferences? _prefs;
  
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token) async {
    if (_prefs == null) await init();
    await _prefs?.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    if (_prefs == null) await init();
    return _prefs?.getString(_tokenKey);
  }

  static Future<void> removeToken() async {
    if (_prefs == null) await init();
    await _prefs?.remove(_tokenKey);
  }
}