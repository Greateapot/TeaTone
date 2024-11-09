part of 'sort_method_selector_bloc.dart';

sealed class SortMethodSelectorEvent extends Equatable {
  const SortMethodSelectorEvent();

  @override
  List<Object> get props => [];
}

final class SortMethodSelectorSelectingStarted extends SortMethodSelectorEvent {
  const SortMethodSelectorSelectingStarted(this.sortMethod);

  /// current sort method
  final SortMethod sortMethod;
}

final class SortMethodSelectorPreviousSelected extends SortMethodSelectorEvent {
  const SortMethodSelectorPreviousSelected();
}

final class SortMethodSelectorNextSelected extends SortMethodSelectorEvent {
  const SortMethodSelectorNextSelected();
}

final class SortMethodSelectorSelectingCanceled
    extends SortMethodSelectorEvent {
  /// on cancel pressed
  const SortMethodSelectorSelectingCanceled();
}

final class SortMethodSelectorSelectingCompleted
    extends SortMethodSelectorEvent {
  /// on confirm pressed
  const SortMethodSelectorSelectingCompleted([this.callback]);

  /// called with selected sort method
  final void Function(SortMethod)? callback;
}
