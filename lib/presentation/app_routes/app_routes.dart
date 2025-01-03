import 'package:aak_test/export.dart';
import 'package:aak_test/presentation/screens/signin/sigin_screen.dart';
import 'package:aak_test/presentation/screens/signup/signup_screen.dart';

class AppRoutes {
  static const welcome = '/';

  ///SignIn
  static const signInScreen = '/signInScreen';

  ///SignUp
  static const signUpScreen = '/signUpScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    _currentRoute = settings.name;
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const WelcomeScreen(),
        );
      case signInScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SignInScreen(),
        );
      case signUpScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SignUpScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static bool isCurrent(String newRoute) {
    return newRoute == _currentRoute;
  }

  static String? _currentRoute;

  static String? getCurrentRouteName() => _currentRoute;

  static Future<void> setCurrent(String route) async {
    _currentRoute = route;
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
