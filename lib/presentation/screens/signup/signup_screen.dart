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

  List<DropdownMenuItem<String>> userTypes = [
    const DropdownMenuItem<String>(
      value: 'researcher',
      child: Text('Researcher'),
    ),
    const DropdownMenuItem<String>(
      value: 'investor',
      child: Text('Investor'),
    ),
    const DropdownMenuItem<String>(
      value: 'institution_staff',
      child: Text('Institution Staff'),
    ),
    const DropdownMenuItem<String>(
      value: 'service_provider',
      child: Text('Service Provider'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        switch (state.status) {
          case SignUpStatus.error:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.serverMessage),
              ),
            );
            context.read<SignUpBloc>().add(
                  ChangeSignUpStatus(
                    status: SignUpStatus.init,
                  ),
                );
            break;
          case SignUpStatus.loaded:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Sign Up Successful! Check your email for verification.',
                ),
              ),
            );
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).pop();
            });
            context.read<SignUpBloc>().add(
                  ChangeSignUpStatus(
                    status: SignUpStatus.init,
                  ),
                );
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack().fullScreenLoader(
            state: state.status == SignUpStatus.loading,
            loadingWidget: fullScreenLoader(),
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          firstNameController.text = 'faizan';
                          lastNameController.text = 'dev';
                          usernameController.text = 'faizan_dev';
                          emailController.text = 'dummy1@mailinator.com';
                          passwordController.text = '123456';
                          countryController.text = 'Pakistan';
                        });
                      },
                      child: Text(
                        'Sign Up to AKK',
                        style: textStyles.semiBold,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Form(
                          key: key,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const SizedBox(
                                height: 20,
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
                                height: 10,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CommonTextField(
                                controller: countryController,
                                labelText: 'Country',
                                focusNode: countryFocusNode,
                              ),
                              DropdownButton(
                                items: userTypes,
                                value: state.selectedUserType,
                                onChanged: (value) {
                                  context.read<SignUpBloc>().add(
                                        ChangeSelectedUserType(
                                          selectedUserType: value.toString(),
                                        ),
                                      );
                                },
                                hint: const Text('Select User Type'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CommonButton(
                                onPressed: () {
                                  if (key.currentState!.validate()) {
                                    context.read<SignUpBloc>().add(
                                          SignUpUser(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            firstName: firstNameController.text,
                                            lastName: lastNameController.text,
                                            userName: usernameController.text,
                                            userType: state.selectedUserType,
                                            country: countryController.text,
                                          ),
                                        );
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
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
