part of 'case_bloc.dart';

enum RecordSelectingInitiatorType { player, deletor }

sealed class CaseState extends Equatable {
  const CaseState();

  @override
  List<Object> get props => [];
}

final class CaseInitial extends CaseState {
  const CaseInitial();
}

final class CaseCanceled extends CaseState {
  const CaseCanceled();
}

final class CaseDone extends CaseState {
  const CaseDone();
}

final class CaseRecorderRunInProgress extends CaseState {
  const CaseRecorderRunInProgress();
}

final class CasePlayerRunInProgress extends CaseState {
  const CasePlayerRunInProgress();
}

final class CaseDeletorRunInProgress extends CaseState {
  const CaseDeletorRunInProgress();
}

final class CaseRecordSelectorRunInProgress extends CaseState {
  const CaseRecordSelectorRunInProgress(this.type);

  final RecordSelectingInitiatorType type;
}
