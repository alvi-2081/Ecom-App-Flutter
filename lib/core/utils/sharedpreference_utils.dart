import 'package:ecommerece_app/core/utils/logger_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> getInstance() async {
    return _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<void> setString(String? key, String? value) async {
    LoggerUtil.logs('setString $key : $value');
    _sharedPreferences = await getInstance();
    await _sharedPreferences!.setString(key ?? '', value ?? '');
  }

  Future<String?> getString(String? key) async {
    LoggerUtil.logs('getString $key');
    _sharedPreferences = await getInstance();
    final stringValue = _sharedPreferences!.getString(key!);
    return stringValue;
  }

  ///remove value from prefs
  Future<bool> removeValue(String? key) async {
    LoggerUtil.logs('removeValue $key');
    _sharedPreferences = await getInstance();
    final isRemoved = await _sharedPreferences!.remove(key!);
    return isRemoved;
  }

  ///check existing value in prefs
  Future<bool> isExist(String? key) async {
    LoggerUtil.logs('checkValue $key');
    _sharedPreferences = await getInstance();
    return _sharedPreferences!.containsKey(key!);
  }
}
