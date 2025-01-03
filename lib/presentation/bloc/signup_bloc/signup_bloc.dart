import 'package:aak_test/export.dart';

part 'signup_state.dart';

part 'signup_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final WelcomeUseCase welcomeUseCase;

  SignUpBloc({required this.welcomeUseCase}) : super(const SignUpState()) {
    on<ChangeSignUpStatus>(_changeStatus);
    on<ChangeSelectedUserType>(_changeSelectedUserType);
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
}
