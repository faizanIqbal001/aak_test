part of 'welcome_bloc.dart';

abstract class WelcomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeStatus extends WelcomeEvent {
  final WelcomeStatus status;

  ChangeStatus({required this.status});
}
