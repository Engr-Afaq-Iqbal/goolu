import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '/Config/app_config.dart';

class AppStorage {
  static final box = GetStorage();

  static final String _appNameForKey = AppConfig.appName.removeAllWhitespace;
  static final String _tokenStorageKey = "${_appNameForKey}UserToken";
  // static final String _loggedUserDataStorageKey =
  //     "${_appNameForKey}LoggedUserData";

  static Future<void> clearKeyData(String key) async {
    await box.remove(key);
  }

  static Future<void> _write(String key, dynamic value) async {
    await box.write(key, value);
  }

  static T? _read<T>(String key) {
    return box.read(key);
  }

  static bool _storageHasData(String key) {
    return box.hasData(key);
  }

  /// Localization
  // static isStorageHasLocalizationData() => _storageHasData(_langStorageKey);

  // static setLocalizationData(String? _res) async =>
  //     await _write(_langStorageKey, _res);

  // static OauthModel? getLocalizationData() {
  //   try {
  //     return oauthModelFromJson(_read(_langStorageKey));
  //   } catch (e) {
  //     return null;
  //   }
  // }

  /// User Access Token Storage
  static isStorageHasUserToken() => _storageHasData(_tokenStorageKey);

  static setUserToken(String res) async => await _write(_tokenStorageKey, res);

  // static LoginModel? getUserToken() {
  //   try {
  //     return loginModelFromJson(_read(_tokenStorageKey));
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // static LoginModel? getUserToken() {
  //   try {
  //     final jsonString = _read<String>(_tokenStorageKey);
  //     if (jsonString == null || jsonString.isEmpty) return null;
  //     return loginModelFromJson(jsonString);
  //   } catch (e) {
  //     logger.e('Error parsing token: $e');
  //     return null;
  //   }
  // }
}
