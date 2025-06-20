import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  final Connectivity _connectivity;
  NetworkInfo(this._connectivity);

  Future<bool> get hasConnection async {
    final List<ConnectivityResult> connectivityResult = await (_connectivity.checkConnectivity());
    return connectivityResult.any((element) => element == ConnectivityResult.mobile) || connectivityResult.any((element) => element == ConnectivityResult.wifi);
  }
}
