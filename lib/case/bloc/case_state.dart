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

final class CasePlayerRunInProgress extends CaseState {
  const CasePlayerRunInProgress();
}

final class CasePlayerRunPause extends CaseState {
  const CasePlayerRunPause();
}

final class CasePlayerRecordSelecting extends CaseState {
  const CasePlayerRecordSelecting({
    required this.records,
    this.selectedIndex = 0,
  });

  final int selectedIndex;
  final List records;

  CasePlayerRecordSelecting copyWith(int selectedIndex) =>
      CasePlayerRecordSelecting(
        records: records,
        selectedIndex: selectedIndex,
      );
}

final class CaseDeletingRecordSelecting extends CaseState {
  const CaseDeletingRecordSelecting({
    required this.records,
    this.selectedIndex = 0,
  });

  final int selectedIndex;
  final List records;

  CaseDeletingRecordSelecting copyWith(int selectedIndex) =>
      CaseDeletingRecordSelecting(
        records: records,
        selectedIndex: selectedIndex,
      );
}
