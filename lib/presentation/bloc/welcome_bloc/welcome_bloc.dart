import 'package:aak_test/export.dart';

part 'welcome_state.dart';

part 'welcome_event.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final WelcomeUseCase welcomeUseCase;

  WelcomeBloc({required this.welcomeUseCase}) : super(const WelcomeState()) {
    on<ChangeStatus>(_changeStatus);
  }

  Future<void> _changeStatus(
      ChangeStatus event, Emitter<WelcomeState> emit) async {
    emit(
      state.copyWith(
        status: event.status,
      ),
    );
  }
}
