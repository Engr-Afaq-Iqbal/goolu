import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '/Config/app_config.dart';
import '../Model/UserModel/usersModel.dart';
import '../Utils/utils.dart';

class AppStorage {
  static final box = GetStorage();

  static final String _appNameForKey = AppConfig.appName.removeAllWhitespace;
  static final String _tokenStorageKey = "${_appNameForKey}UserToken";
  static final String _userDataStorageKey = "${_appNameForKey}LoggedUserData";
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

  /// User Access Token Storage
  static isStorageHasUserToken() => _storageHasData(_tokenStorageKey);

  static setUserToken(String res) async => await _write(_tokenStorageKey, res);

  static setUserData(UserModel userData) async =>
      await _write(_userDataStorageKey, userData.toJson());

  static isStorageHasUserData() => _storageHasData(_userDataStorageKey);

  // static UserModel? getUserData() {
  //   try {
  //     logger
  //         .i('Reading data === --->> ${_read<UserModel>(_userDataStorageKey)}');
  //     return _read<UserModel>(_userDataStorageKey);
  //   } catch (e) {
  //     logger.e(e);
  //     return null;
  //   }
  // }
  static UserModel? getUserData() {
    try {
      // Read the data as a JSON string
      final userDataJson = _read<String>(_userDataStorageKey);

      // If userDataJson is not null, convert it to UserModel
      if (userDataJson != null) {
        return UserModel.fromJson(userDataJson);
      } else {
        logger.e('No user data found in storage.');
        return null;
      }
    } catch (e) {
      logger.e('Error reading user data: $e');
      return null;
    }
  }
}
