part of 'deletor_bloc.dart';

sealed class DeletorEvent extends Equatable {
  const DeletorEvent();

  @override
  List<Object> get props => [];
}

final class DeletorStarted extends DeletorEvent {
  const DeletorStarted(this.record);

  final Record record;
}

final class DeletorConfirmed extends DeletorEvent {
  const DeletorConfirmed({this.onSuccess, this.onFailure});

  final void Function()? onSuccess;
  final void Function()? onFailure;
}

final class DeletorCanceled extends DeletorEvent {
  const DeletorCanceled();
}
