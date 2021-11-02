import 'package:connectivity/connectivity.dart';

abstract class NetworkInfo {
  Future<bool>? get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);
  @override
  Future<bool>? get isConnected async {
    bool hasConnection;
    ConnectivityResult connectivityResult =
        await (new Connectivity().checkConnectivity());
    print(connectivityResult);
    print("ssssss");

    if ((connectivityResult == ConnectivityResult.mobile) ||
        (connectivityResult == ConnectivityResult.wifi)) {
      // return Future<bool>.value(true);
      hasConnection = true;
    } else {
      // return Future<bool>.value(false);
      hasConnection = false;
    }
    return hasConnection;
  }
}
