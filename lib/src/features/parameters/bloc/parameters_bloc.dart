import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teatone/src/features/storage/storage.dart';

part 'parameters_event.dart';
part 'parameters_state.dart';

class ParametersBloc extends Bloc<ParametersEvent, ParametersState> {
  ParametersBloc(this.storageRepository) : super(const ParametersInitial()) {
    on<ParametersLoad>(_onLoad);
  }

  final StorageRepository storageRepository;

  void _onLoad(
    ParametersLoad event,
    Emitter<ParametersState> emit,
  ) async {
    final parameters = await storageRepository.getParameters();

    emit(ParametersLoaded(parameters: parameters));
  }
}
