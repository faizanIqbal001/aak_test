import 'package:aak_test/export.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        context.read<WelcomeBloc>().add(
              ChangeStatus(
                status: WelcomeStatus.loaded,
              ),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeResources(context: context);
    return BlocConsumer<WelcomeBloc, WelcomeState>(
      listener: (context, state) {
        if (state.status == WelcomeStatus.loaded) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.signInScreen,
          );
          context.read<WelcomeBloc>().add(
                ChangeStatus(
                  status: WelcomeStatus.init,
                ),
              );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/png/logo.png',
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome To AKK',
                  style: textStyles.bold.copyWith(
                      fontSize: sizes.fontRatio * 18, color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: sizes.heightRatio * 10,
                  width: sizes.widthRatio * 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const LinearProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
