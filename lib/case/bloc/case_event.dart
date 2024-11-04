part of 'case_bloc.dart';

sealed class CaseEvent extends Equatable {
  const CaseEvent();

  @override
  List<Object> get props => [];
}

final class CaseRecordButtonPressed extends CaseEvent {
  const CaseRecordButtonPressed();
}

final class CasePauseButtonPressed extends CaseEvent {
  const CasePauseButtonPressed();
}

final class CasePlayButtonPressed extends CaseEvent {
  const CasePlayButtonPressed();
}

final class CaseStopButtonPressed extends CaseEvent {
  const CaseStopButtonPressed();
}

final class CaseUpButtonPressed extends CaseEvent {
  const CaseUpButtonPressed();
}

final class CaseDownButtonPressed extends CaseEvent {
  const CaseDownButtonPressed();
}

final class CaseLeftButtonPressed extends CaseEvent {
  const CaseLeftButtonPressed();
}

final class CaseRightButtonPressed extends CaseEvent {
  const CaseRightButtonPressed();
}

final class CaseConfirmButtonPressed extends CaseEvent {
  const CaseConfirmButtonPressed();
}

final class CaseCancelButtonPressed extends CaseEvent {
  const CaseCancelButtonPressed();
}

final class CaseDeleteButtonPressed extends CaseEvent {
  const CaseDeleteButtonPressed();
}

final class CaseSettingsButtonPressed extends CaseEvent {
  const CaseSettingsButtonPressed();
}

final class CaseRecordSelected extends CaseEvent {
  const CaseRecordSelected(this.path);

  final String path;
}
