part of 'parameter_selector_bloc.dart';

sealed class ParameterSelectorEvent extends Equatable {
  const ParameterSelectorEvent();

  @override
  List<Object> get props => [];
}

final class ParameterSelectorSelectingStarted extends ParameterSelectorEvent {
  const ParameterSelectorSelectingStarted();
}

final class ParameterSelectorPreviousSelected extends ParameterSelectorEvent {
  const ParameterSelectorPreviousSelected();
}

final class ParameterSelectorNextSelected extends ParameterSelectorEvent {
  const ParameterSelectorNextSelected();
}

final class ParameterSelectorSelectingCanceled extends ParameterSelectorEvent {
  /// on cancel pressed
  const ParameterSelectorSelectingCanceled();
}

final class ParameterSelectorSelectingCompleted extends ParameterSelectorEvent {
  /// on confirm pressed
  const ParameterSelectorSelectingCompleted([this.callback]);

  /// called with selected param
  final void Function(Parameter)? callback;
}
