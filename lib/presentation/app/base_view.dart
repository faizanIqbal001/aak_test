import 'package:aak_test/export.dart';

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    required this.navigatorKey,
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool isTimeElapsed = false;
  final GlobalKey _myKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        key: _myKey,
        navigatorKey: widget.navigatorKey,
        title: 'AAK Test',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.welcome,
        builder: (_, __) {
          return __!;
        },
      ),
    );
  }
}
