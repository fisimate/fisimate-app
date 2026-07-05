import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityHelper {
  static Future<ConnectivityResult> checkConnection() async {
    final results = await Connectivity().checkConnectivity();
    return results.first;
  }
}
