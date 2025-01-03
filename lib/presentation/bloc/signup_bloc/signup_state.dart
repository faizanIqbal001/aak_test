part of 'signup_bloc.dart';

class SignUpState extends Equatable {
  final SignUpStatus status;
  final String selectedUserType;
  final String serverMessage;

  const SignUpState({
    this.status = SignUpStatus.init,
    this.selectedUserType = 'researcher',
    this.serverMessage = '',
  });

  SignUpState copyWith({
    SignUpStatus? status,
    String? selectedUserType,
    String? serverMessage,
  }) {
    return SignUpState(
      status: status ?? this.status,
      selectedUserType: selectedUserType ?? this.selectedUserType,
      serverMessage: serverMessage ?? this.serverMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedUserType,
        serverMessage,
      ];
}
