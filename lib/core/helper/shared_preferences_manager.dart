
import 'package:riverpod_shopping/product/extension/shared_pref_extension.dart';
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

  Future<void> saveCart(
      {required SharedPreferencesEnum key, required String value}) async {
    await _prefs?.setString(key.rawValue, value);
  }

  Future<String?> getCart({required SharedPreferencesEnum key}) async {
    return _prefs?.getString(key.rawValue);
  }

  Future<void> removeCart({required SharedPreferencesEnum key}) async {
    await _prefs?.remove(key.rawValue);
  }
}
