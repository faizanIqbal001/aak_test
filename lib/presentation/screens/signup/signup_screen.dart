import 'package:aak_test/export.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  FocusNode firstNameFocusNode = FocusNode();
  TextEditingController lastNameController = TextEditingController();
  FocusNode lastNameFocusNode = FocusNode();
  TextEditingController usernameController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController countryController = TextEditingController();
  FocusNode countryFocusNode = FocusNode();

  GlobalKey<FormState> key = GlobalKey<FormState>();

  List<String> userTypes = [
    'researcher',
    'investor',
    'institution_staff',
    'service_provider'
        'service_provider'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    'assets/png/logo.png',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Sign Up to AKK',
                    style: textStyles.semiBold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextField(
                    controller: firstNameController,
                    labelText: 'First Name',
                    focusNode: firstNameFocusNode,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextField(
                    controller: lastNameController,
                    labelText: 'Last Name',
                    focusNode: lastNameFocusNode,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextField(
                    controller: usernameController,
                    labelText: 'Username',
                    focusNode: usernameFocusNode,
                  ),
                  const SizedBox(
                    height: 10,
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
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        // Navigator.pushNamed(
                        //   context,
                        //   AppRoutes.signInScreen,
                        // );
                      }
                    },
                    label: 'Sign Up',
                    isLoading: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: textStyles.semiBold,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Sign In',
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
          )),
    );
  }
}
