import 'package:connectivity_plus/connectivity_plus.dart';

import 'cehck_internt_connection.dart';

Future<bool> checkInternetStatus() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.none)) {
    return false;
  }

  return await checkInternetAccess();
}
