import 'package:aak_test/export.dart';
import 'package:aak_test/presentation/di/di.dart';
import 'package:http/http.dart' as http;

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
GetIt serviceLocator = GetIt.instance;
Dio dio = Dio();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies(
    onGettingServerException: (exception) async {},
    client: http.Client(),
    dio: dio,
    onClientExpire: () async {},
    onTokenExpire: () async {},
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: serviceLocator<WelcomeBloc>(),
        ),
      ],
      child: MyApp(navigatorKey: navigatorKey),
    ),
  );
}
