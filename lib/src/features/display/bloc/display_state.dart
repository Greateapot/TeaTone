part of 'display_bloc.dart';

enum RecordSelectingInitiatorType { player, deletor }

sealed class DisplayState extends Equatable {
  const DisplayState({required this.isDisplayOff});

  final bool isDisplayOff;

  DisplayState copyWith({required bool isDisplayOff});

  @override
  List<Object> get props => [isDisplayOff];
}

final class DisplayHome extends DisplayState {
  const DisplayHome({required super.isDisplayOff});

  @override
  DisplayHome copyWith({required bool isDisplayOff}) =>
      DisplayHome(isDisplayOff: isDisplayOff);
}

final class DisplayFailed extends DisplayState {
  const DisplayFailed({required super.isDisplayOff});

  @override
  DisplayFailed copyWith({required bool isDisplayOff}) =>
      DisplayFailed(isDisplayOff: isDisplayOff);
}

final class DisplayCanceled extends DisplayState {
  const DisplayCanceled({required super.isDisplayOff});

  @override
  DisplayCanceled copyWith({required bool isDisplayOff}) =>
      DisplayCanceled(isDisplayOff: isDisplayOff);
}

final class DisplayDone extends DisplayState {
  const DisplayDone({required super.isDisplayOff});

  @override
  DisplayDone copyWith({required bool isDisplayOff}) =>
      DisplayDone(isDisplayOff: isDisplayOff);
}

final class DisplayRecorder extends DisplayState {
  const DisplayRecorder({required super.isDisplayOff});

  @override
  DisplayRecorder copyWith({required bool isDisplayOff}) =>
      DisplayRecorder(isDisplayOff: isDisplayOff);
}

final class DisplayPlayer extends DisplayState {
  const DisplayPlayer({required super.isDisplayOff});

  @override
  DisplayPlayer copyWith({required bool isDisplayOff}) =>
      DisplayPlayer(isDisplayOff: isDisplayOff);
}

final class DisplayDeletor extends DisplayState {
  const DisplayDeletor({required super.isDisplayOff});

  @override
  DisplayDeletor copyWith({required bool isDisplayOff}) =>
      DisplayDeletor(isDisplayOff: isDisplayOff);
}

final class DisplayRecordSelector extends DisplayState {
  const DisplayRecordSelector(this.type, {required super.isDisplayOff});

  final RecordSelectingInitiatorType type;

  @override
  DisplayRecordSelector copyWith({required bool isDisplayOff}) =>
      DisplayRecordSelector(type, isDisplayOff: isDisplayOff);

  @override
  List<Object> get props => [isDisplayOff, type];
}

final class DisplayParameterSelector extends DisplayState {
  const DisplayParameterSelector({required super.isDisplayOff});

  @override
  DisplayParameterSelector copyWith({required bool isDisplayOff}) =>
      DisplayParameterSelector(isDisplayOff: isDisplayOff);
}

final class DisplaySortMethodSelector extends DisplayState {
  const DisplaySortMethodSelector({required super.isDisplayOff});

  @override
  DisplaySortMethodSelector copyWith({required bool isDisplayOff}) =>
      DisplaySortMethodSelector(isDisplayOff: isDisplayOff);
}

final class DisplayStorageTypeSelector extends DisplayState {
  const DisplayStorageTypeSelector({required super.isDisplayOff});

  @override
  DisplayStorageTypeSelector copyWith({required bool isDisplayOff}) =>
      DisplayStorageTypeSelector(isDisplayOff: isDisplayOff);
}
