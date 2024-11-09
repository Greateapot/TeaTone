part of 'display_bloc.dart';

sealed class DisplayEvent extends Equatable {
  const DisplayEvent();

  @override
  List<Object> get props => [];
}

final class DisplayStateChanged extends DisplayEvent {
  const DisplayStateChanged();
}

final class DisplayHomeDisplayed extends DisplayEvent {
  const DisplayHomeDisplayed();
}

final class DisplayFailedDisplayed extends DisplayEvent {
  const DisplayFailedDisplayed();
}

final class DisplayCanceledDisplayed extends DisplayEvent {
  const DisplayCanceledDisplayed();
}

final class DisplayDoneDisplayed extends DisplayEvent {
  const DisplayDoneDisplayed();
}

final class DisplayRecorderDisplayed extends DisplayEvent {
  const DisplayRecorderDisplayed();
}

final class DisplayPlayerDisplayed extends DisplayEvent {
  const DisplayPlayerDisplayed();
}

final class DisplayDeletorDisplayed extends DisplayEvent {
  const DisplayDeletorDisplayed();
}

final class DisplayRecordSelectorDisplayed extends DisplayEvent {
  const DisplayRecordSelectorDisplayed(this.type);

  final RecordSelectingInitiatorType type;
}

final class DisplayParameterSelectorDisplayed extends DisplayEvent {
  const DisplayParameterSelectorDisplayed();
}

final class DisplaySortMethodSelectorDisplayed extends DisplayEvent {
  const DisplaySortMethodSelectorDisplayed();
}

final class DisplayStorageTypeSelectorDisplayed extends DisplayEvent {
  const DisplayStorageTypeSelectorDisplayed();
}
