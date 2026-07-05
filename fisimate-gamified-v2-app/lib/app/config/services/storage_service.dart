import 'package:fisimate/app/helpers/secure_storage_helper.dart';

abstract class StorageService {
  StorageService(String s);

  static Future<void> saveAccessToken({required String accessToken}) async {
    await SecureStorageHelper().writeData(key: 'access_token', value: accessToken);
  }

  static Future<String?> getAccessToken() async {
    return await SecureStorageHelper().readData(key: 'access_token');
  }

  static Future<void> saveRefreshToken({required String refreshToken}) async {
    await SecureStorageHelper().writeData(key: 'refresh_token', value: refreshToken);
  }

  static Future<String?> getRefreshToken() async {
    return await SecureStorageHelper().readData(key: 'refresh_token');
  }

  static Future<void> saveEmail({required String email}) async {
    await SecureStorageHelper().writeData(key: 'email', value: email);
  }

  static Future<String?> getEmail() async {
    return await SecureStorageHelper().readData(key: 'email');
  }

  static Future<void> removeEmail() async {
    await SecureStorageHelper().deleteData(key: 'email');
  }

  static Future<void> saveUser({required String user}) async {
    await SecureStorageHelper().writeData(key: 'user', value: user);
  }

  static Future<String?> getUser() async {
    return await SecureStorageHelper().readData(key: 'user');
  }

  static Future<void> saveLoggedInStatus({required bool status}) async {
    await SecureStorageHelper().writeData(
      key: 'is_logged_in',
      value: status.toString(),
    );
  }

  static Future<bool> getLoggedInStatus() async {
    final status = await SecureStorageHelper().readData(key: 'is_logged_in');
    return status == 'true';
  }

  static Future<void> saveRegisteredStatus({required bool status}) async {
    await SecureStorageHelper().writeData(
      key: 'is_registered',
      value: status.toString(),
    );
  }

  static Future<bool> getRegisteredStatus() async {
    final status = await SecureStorageHelper().readData(key: 'is_registered');
    return status == 'true';
  }

  static Future<void> removeAllExceptEmailAndRegisteredStatus() async {
    await SecureStorageHelper().deleteData(key: 'access_token');
    await SecureStorageHelper().deleteData(key: 'refresh_token');
    await SecureStorageHelper().deleteData(key: 'user');
    await SecureStorageHelper().deleteData(key: 'is_logged_in');
  }
}
