part of 'parameters_bloc.dart';

sealed class ParametersEvent extends Equatable {
  const ParametersEvent();

  @override
  List<Object> get props => [];
}

final class ParametersLoaded extends ParametersEvent {
  const ParametersLoaded();
}

final class ParametersUpdated extends ParametersEvent {
  const ParametersUpdated({
    this.sortMethod,
    this.storageType,
    this.onSuccess,
    this.onFailure,
  });

  final SortMethod? sortMethod;
  final StorageType? storageType;

  final void Function()? onSuccess;
  final void Function()? onFailure;
}
