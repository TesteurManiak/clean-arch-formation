import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl(this._connectivity);

  @override
  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi;
  }
}
