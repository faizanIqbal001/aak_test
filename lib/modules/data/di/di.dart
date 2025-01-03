import 'package:http/http.dart' as http;

import '../../../../export.dart';

Future<void> initializeDataLayerDependencies({
  required Function onTokenExpire,
  required Function(String exception) onGettingServerException,
  required http.Client client,
  required Dio dio,
  required Function onClientExpire,
}) async {
  await Future.wait(
    [
      initializeNetworkDependencies(
        onClientExpire: onClientExpire,
        dio: dio,
        client: client,
        onTokenExpire: onTokenExpire,
        onGettingServerException: (exception) => onGettingServerException(
          exception,
        ),
      ),
      initializeRepoDependencies(),
    ],
  );
}
