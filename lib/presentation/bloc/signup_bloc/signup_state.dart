part of 'signup_bloc.dart';

class SignUpState extends Equatable {
  final SignUpStatus status;
  final String selectedUserType;

  const SignUpState({
    this.status = SignUpStatus.init,
    this.selectedUserType = '',
  });

  SignUpState copyWith({
    SignUpStatus? status,
    String? selectedUserType,
  }) {
    return SignUpState(
      status: status ?? this.status,
      selectedUserType: selectedUserType ?? this.selectedUserType,
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedUserType,
      ];
}
