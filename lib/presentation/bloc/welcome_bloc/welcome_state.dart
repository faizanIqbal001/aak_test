part of 'welcome_bloc.dart';

class WelcomeState extends Equatable {
  final WelcomeStatus status;

  const WelcomeState({
    this.status = WelcomeStatus.init,
  });

  WelcomeState copyWith({
    WelcomeStatus? status,
  }) {
    return WelcomeState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
