part of 'parameters_bloc.dart';

sealed class ParametersState extends Equatable {
  const ParametersState(this.parameters);

  final Parameters? parameters;

  @override
  List<Object?> get props => [parameters];
}

final class ParametersInitial extends ParametersState {
  const ParametersInitial() : super(null);
}

final class ParametersLoaded extends ParametersState {
  const ParametersLoaded({required Parameters parameters}) : super(parameters);
}
