import 'package:aak_test/export.dart';
import 'package:aak_test/modules/domain/use_cases/welcome_use_case/welcome_use_case.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

Future<void> initializeDomainLayerDependencies({
  required Function onTokenExpire,
  required http.Client client,
  required Dio dio,
  required Function onClientExpire,
}) async {
  await welcomeUseCase();

  ///await authUseCase();
}

Future<void> welcomeUseCase() async {
  serviceLocator.registerLazySingleton<WelcomeUseCase>(
    () => WelcomeUseCase(
        // welcomeRepo: serviceLocator(),
        ),
  );
}

// Future<void> authUseCase() async {
//   serviceLocator.registerLazySingleton<AuthUseCase>(
//     () => AuthUseCase(
//       authRepo: serviceLocator(),
//     ),
//   );
// }
