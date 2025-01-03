import 'package:aak_test/export.dart';

part 'welcome_state.dart';

part 'welcome_event.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final WelcomeUseCase welcomeUseCase;

  WelcomeBloc({required this.welcomeUseCase}) : super(const WelcomeState());
}
