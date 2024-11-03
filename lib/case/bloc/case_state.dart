part of 'case_bloc.dart';

sealed class CaseState extends Equatable {
  const CaseState();

  @override
  List<Object> get props => [];
}

final class CaseInitial extends CaseState {
  const CaseInitial();
}

final class CaseRecorderRunInProgress extends CaseState {
  const CaseRecorderRunInProgress();
}

final class CaseRecorderRunPause extends CaseState {
  const CaseRecorderRunPause();
}
