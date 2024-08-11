import 'package:fisimate/app/helpers/secure_storage_helper.dart';

abstract class StorageService {
  StorageService(String s);

  static saveAccessToken({required String accessToken}) async {
    await SecureStorageHelper()
        .writeData(key: 'access_token', value: accessToken);
  }

  static getAccessToken() async {
    return await SecureStorageHelper().readData(key: 'access_token');
  }

  static saveRefreshToken({required String refreshToken}) async {
    await SecureStorageHelper()
        .writeData(key: 'refresh_token', value: refreshToken);
  }

  static getRefreshToken() async {
    return await SecureStorageHelper().readData(key: 'refresh_token');
  }

  static saveEmail({required String email}) async {
    await SecureStorageHelper().writeData(key: 'email', value: email);
  }

  static getEmail() async {
    return await SecureStorageHelper().readData(key: 'email');
  }

  static removeEmail() async {
    await SecureStorageHelper().deleteData(key: 'email');
  }

  static saveUser({required String user}) async {
    await SecureStorageHelper().writeData(key: 'user', value: user);
  }

  static getUser() async {
    return await SecureStorageHelper().readData(key: 'user');
  }

  static saveLoggedInStatus({required bool status}) async {
    await SecureStorageHelper().writeData(
      key: 'is_logged_in',
      value: status.toString(),
    );
  }

  static getLoggedInStatus() async {
    final status = await SecureStorageHelper().readData(key: 'is_logged_in');
    return status == 'true';
  }

  static saveRegisteredStatus({required bool status}) async {
    await SecureStorageHelper().writeData(
      key: 'is_registered',
      value: status.toString(),
    );
  }

  static getRegisteredStatus() async {
    final status = await SecureStorageHelper().readData(key: 'is_registered');
    return status == 'true';
  }

  static removeAllExceptEmailAndRegisteredStatus() async {
    await SecureStorageHelper().deleteData(key: 'access_token');
    await SecureStorageHelper().deleteData(key: 'refresh_token');
    await SecureStorageHelper().deleteData(key: 'user');
    await SecureStorageHelper().deleteData(key: 'is_logged_in');
  }
}
