import 'package:connectivity/connectivity.dart';

class ConnectionService {
  static ConnectivityResult lastConnectionResult;

  static bool get onMobileInternet => lastConnectionResult == ConnectivityResult.mobile;
  static bool get onWifi => lastConnectionResult == ConnectivityResult.wifi;

  ConnectionService() {
    Connectivity().onConnectivityChanged.listen((result) {
      lastConnectionResult = result;
    });
  }

  static Future<void> init() async {
    lastConnectionResult = await Connectivity().checkConnectivity();
  }
}
