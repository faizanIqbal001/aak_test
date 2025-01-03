import 'package:aak_test/export.dart';

import '../../../main.dart';

Future<void> initializeRepoDependencies() async {
  serviceLocator.registerLazySingleton<WelcomeRepo>(
    () => WelcomeRepoImpl(
      networkHelper: serviceLocator(),
    ),
  );
}
