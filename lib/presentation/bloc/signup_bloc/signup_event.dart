part of 'signup_bloc.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeSignUpStatus extends SignUpEvent {
  final SignUpStatus status;

  ChangeSignUpStatus({required this.status});
}

class ChangeSelectedUserType extends SignUpEvent {
  final String selectedUserType;

  ChangeSelectedUserType({required this.selectedUserType});
}

class SignUpUser extends SignUpEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String userName;
  final String userType;
  final String country;

  SignUpUser({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.userType,
    required this.country,
  });
}
