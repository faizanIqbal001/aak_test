import 'package:http/http.dart' as http;
import 'package:aak_test/export.dart';

import '../../../main.dart';


Future<void> initializeNetworkDependencies({
  required Function onTokenExpire,
  required http.Client client,
  required Dio dio,
  required Function onClientExpire,
}) async {

  serviceLocator.registerLazySingleton<NetworkHelper>(
    () => NetworkHelperImpl(
      onClientExpire: onClientExpire,
      dio: dio,
      client: client,
      onTokenExpire: onTokenExpire,
    ),
  );
}
