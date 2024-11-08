part of 'parameters_bloc.dart';

sealed class ParametersEvent extends Equatable {
  const ParametersEvent();

  @override
  List<Object> get props => [];
}

final class ParametersLoad extends ParametersEvent {
  const ParametersLoad();
}
