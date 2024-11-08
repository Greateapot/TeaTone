part of 'deletor_bloc.dart';

sealed class DeletorState extends Equatable {
  const DeletorState();

  @override
  List<Object> get props => [];
}

final class DeletorInitial extends DeletorState {
  /// Состояние для простоя
  const DeletorInitial();
}

final class DeletorProcessing extends DeletorState {
  const DeletorProcessing(this.path);

  final String path;
}
