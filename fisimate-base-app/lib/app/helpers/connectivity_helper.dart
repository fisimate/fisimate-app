import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityHelper {
  static Future<ConnectivityResult> checkConnection() async {
    return await (Connectivity().checkConnectivity());
  }
}
