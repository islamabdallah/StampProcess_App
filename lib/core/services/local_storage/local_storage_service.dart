// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class CacheHelper
// {
//   static late SharedPreferences sharedPreferences;
//
//   static init() async
//   {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }
//
//   static dynamic getData({
//     required String key,
//   }) {
//     return sharedPreferences.get(key);
//   }
//
//   static Future<bool> saveData({
//     required String key,
//     required dynamic value,
//   }) async {
//     if (value is String) return await sharedPreferences.setString(key, value);
//     if (value is int) return await sharedPreferences.setInt(key, value);
//     if (value is bool) return await sharedPreferences.setBool(key, value);
//
//     return await sharedPreferences.setDouble(key, value);
//   }
//
//   static Future<bool> removeData({
//     required String key,
//   }) async
//   {
//     return await sharedPreferences.remove(key);
//   }
// }
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPreferenceHelper {
//   Future<SharedPreferences> _sharedPreference;
//   static const String is_dark_mode = "is_dark_mode";
//   static const String language_code = "language_code";
//
//   SharedPreferenceHelper() {
//     _sharedPreference = SharedPreferences.getInstance();
//   }
//
//   //Theme module
//   Future<void> changeTheme(bool value) {
//     return _sharedPreference.then((prefs) {
//       return prefs.setBool(is_dark_mode, value);
//     });
//   }
//
//   Future<bool> get isDarkMode {
//     return _sharedPreference.then((prefs) {
//       return prefs.getBool(is_dark_mode) ?? false;
//     });
//   }
//
//   //Locale module
//   Future<String> get appLocale {
//     return _sharedPreference.then((prefs) {
//       return prefs.getString(language_code) ?? null;
//     });
//   }
//
//   Future<void> changeLanguage(String value) {
//     return _sharedPreference.then((prefs) {
//       return prefs.setString(language_code, value);
//     });
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
   static late GetStorage sharedPreferences;


  static init() async
  {
    await GetStorage.init();
    sharedPreferences = GetStorage();
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.read(key);
  }

  static Future<void> saveData({
    required String key,
    required dynamic value,
  }) async {
    return sharedPreferences.write(key, value);

  }

  static Future<void> removeData({
    required String key,
  }) async
  {
    return  sharedPreferences.remove(key);
  }
}
