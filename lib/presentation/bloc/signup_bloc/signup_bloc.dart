import 'dart:convert';

import 'package:aak_test/export.dart';

part 'signup_state.dart';

part 'signup_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthUseCase authUseCase;

  SignUpBloc({required this.authUseCase}) : super(const SignUpState()) {
    on<ChangeSignUpStatus>(_changeStatus);
    on<ChangeSelectedUserType>(_changeSelectedUserType);
    on<SignUpUser>(_signUpUser);
  }

  Future<void> _changeStatus(
      ChangeSignUpStatus event, Emitter<SignUpState> emit) async {
    emit(
      state.copyWith(
        status: event.status,
      ),
    );
  }

  Future<void> _changeSelectedUserType(
      ChangeSelectedUserType event, Emitter<SignUpState> emit) async {
    emit(
      state.copyWith(
        selectedUserType: event.selectedUserType,
      ),
    );
  }

  Future<void> _signUpUser(SignUpUser event, Emitter<SignUpState> emit) async {
    emit(
      state.copyWith(
        status: SignUpStatus.loading,
      ),
    );
    final result = await authUseCase.signUpUser(
      email: event.email,
      password: event.password,
      firstName: event.firstName,
      lastName: event.lastName,
      userName: event.userName,
      userType: event.userType,
      country: event.country,
    );
    result.fold(
      (success) {
        emit(
          state.copyWith(
            status: SignUpStatus.loaded,
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(
            status: SignUpStatus.error,
            serverMessage: jsonDecode(error.message),
          ),
        );
      },
    );
  }
}
