import 'package:aak_test/export.dart';

import '../../main.dart';

Future<void> initializeBlocs() async {
  serviceLocator.registerLazySingleton(
    () => WelcomeBloc(
      welcomeUseCase: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => SignUpBloc(
      authUseCase: serviceLocator(),
    ),
  );
}
