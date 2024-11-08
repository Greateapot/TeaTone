part of 'deletor_bloc.dart';

sealed class DeletorEvent extends Equatable {
  const DeletorEvent();

  @override
  List<Object> get props => [];
}

final class DeletorStarted extends DeletorEvent {
  const DeletorStarted(this.path);

  final String path;
}

final class DeletorConfirmed extends DeletorEvent {
  const DeletorConfirmed();
}

final class DeletorCanceled extends DeletorEvent {
  const DeletorCanceled();
}
