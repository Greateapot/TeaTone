import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teatone/src/features/storage/storage.dart';

part 'parameters_event.dart';
part 'parameters_state.dart';

class ParametersBloc extends Bloc<ParametersEvent, ParametersState> {
  ParametersBloc(this.storageRepository) : super(const ParametersInitial()) {
    on<ParametersLoaded>(_onLoaded);
    on<ParametersUpdated>(_onUpdated);
  }

  final StorageRepository storageRepository;

  void _onLoaded(
    ParametersLoaded event,
    Emitter<ParametersState> emit,
  ) async {
    final parameters = await storageRepository.getParameters();

    emit(ParametersInitial(parameters: parameters));
  }

  void _onUpdated(
    ParametersUpdated event,
    Emitter<ParametersState> emit,
  ) async {
    final defaults = Parameters.defaults();

    final parameters = Parameters(
      sortMethod: event.sortMethod ??
          state.parameters?.sortMethod ??
          defaults.sortMethod,
      storageType: event.storageType ??
          state.parameters?.storageType ??
          defaults.storageType,
    );

    final result = await storageRepository.setParameters(parameters);

    if (event.onSuccess != null && result) event.onSuccess!();
    if (event.onFailure != null && !result) event.onFailure!();

    if (result) emit(ParametersInitial(parameters: parameters));
  }
}
