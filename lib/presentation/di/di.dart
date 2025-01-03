import 'package:aak_test/export.dart';
import 'package:http/http.dart' as http;

import 'di_bloc.dart';

Future<void> initializeDependencies({
  required Function onTokenExpire,
  required Function(String exception) onGettingServerException,
  required http.Client client,
  required Dio dio,
  required Function onClientExpire,
}) async {
  await Future.wait(
    [
      initializeDomainLayerDependencies(
        onClientExpire: onClientExpire,
        dio: dio,
        client: client,
        onTokenExpire: onTokenExpire,
      ),
      initializeBlocs(),
    ],
  );
}
