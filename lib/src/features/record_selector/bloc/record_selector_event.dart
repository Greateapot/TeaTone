part of 'record_selector_bloc.dart';

sealed class RecordSelectorEvent extends Equatable {
  const RecordSelectorEvent();

  @override
  List<Object> get props => [];
}

final class RecordSelectorStarted extends RecordSelectorEvent {
  /// on play/delete pressed (two-phased events)
  const RecordSelectorStarted();
}

final class RecordSelectorPreviousSelected extends RecordSelectorEvent {
  /// on down pressed
  const RecordSelectorPreviousSelected();
}

final class RecordSelectorNextSelected extends RecordSelectorEvent {
  /// on up pressed
  const RecordSelectorNextSelected();
}

final class RecordSelectorSelectingCanceled extends RecordSelectorEvent {
  /// on cancel pressed
  const RecordSelectorSelectingCanceled();
}

final class RecordSelectorSelectingCompleted extends RecordSelectorEvent {
  /// on confirm pressed
  const RecordSelectorSelectingCompleted([this.callback]);

  /// called with selected record
  final void Function(dynamic)? callback;
}
