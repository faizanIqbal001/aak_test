import 'package:aak_test/export.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/png/logo.png',
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Sign In to AKK',
              style: textStyles.semiBold,
            ),
            const SizedBox(
              height: 20,
            ),
            CommonTextField(
              controller: emailController,
              labelText: 'Email',
              focusNode: emailFocusNode,
            ),
            const SizedBox(
              height: 10,
            ),
            CommonTextField(
              controller: passwordController,
              labelText: 'Password',
              focusNode: passwordFocusNode,
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            CommonButton(
              onPressed: () {
                // Navigator.pushNamed(
                //   context,
                //   AppRoutes.signInScreen,
                // );
              },
              label: 'Sign In',
              isLoading: false,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: textStyles.semiBold,
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.signUpScreen,
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: textStyles.semiBold.copyWith(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
