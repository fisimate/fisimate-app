import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> writeData({required String key, required String value}) async {
    log('Successfully write data $key');
    await _storage.write(key: key, value: value);
  }

  Future<String?> readData({required String key}) async {
    log('Data $key from secure storage: ${await _storage.read(key: key)}');
    return await _storage.read(key: key);
  }

  Future<void> deleteData({required String key}) async {
    log('Data $key from secure storage is Deleted');
    await _storage.delete(key: key);
  }
}
