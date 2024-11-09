part of 'parameter_selector_bloc.dart';

enum Parameter { sortMethod, storageType }

sealed class ParameterSelectorState extends Equatable {
  const ParameterSelectorState();

  @override
  List<Object> get props => [];
}

final class ParameterSelectorInitial extends ParameterSelectorState {
  const ParameterSelectorInitial();
}

final class ParameterSelectorProcessing extends ParameterSelectorState {
  const ParameterSelectorProcessing({
    required this.parameters,
    required this.selectedIndex,
  });

  final List<Parameter> parameters;
  final int selectedIndex;

  ParameterSelectorProcessing copyWith(int selectedIndex) =>
      ParameterSelectorProcessing(
        parameters: parameters,
        selectedIndex: selectedIndex,
      );

  @override
  List<Object> get props => [parameters, selectedIndex];
}
