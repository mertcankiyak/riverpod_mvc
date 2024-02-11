
import 'package:riverpod_mvc/product/extension/shared_pref_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../product/enums/shared_pref_enum.dart';

class SharedPreferencesManager {
  static final SharedPreferencesManager instance = _instance;

  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._internal();

  SharedPreferencesManager._internal();

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences? _prefs;

  Future<void> saveToken(
      {required SharedPreferencesEnum key, required String value}) async {
    await _prefs?.setString(key.rawValue, value);
  }

  Future<String?> getToken({required SharedPreferencesEnum key}) async {
    return _prefs?.getString(key.rawValue);
  }

  Future<void> removeToken({required SharedPreferencesEnum key}) async {
    await _prefs?.remove(key.rawValue);
  }
}
