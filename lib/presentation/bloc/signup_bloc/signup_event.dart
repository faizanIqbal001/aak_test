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
