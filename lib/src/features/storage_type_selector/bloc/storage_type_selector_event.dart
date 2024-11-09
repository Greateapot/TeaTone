part of 'storage_type_selector_bloc.dart';

sealed class StorageTypeSelectorEvent extends Equatable {
  const StorageTypeSelectorEvent();

  @override
  List<Object> get props => [];
}

final class StorageTypeSelectorSelectingStarted
    extends StorageTypeSelectorEvent {
  const StorageTypeSelectorSelectingStarted(this.storageType);

  /// current storage type
  final StorageType storageType;
}

final class StorageTypeSelectorPreviousSelected
    extends StorageTypeSelectorEvent {
  const StorageTypeSelectorPreviousSelected();
}

final class StorageTypeSelectorNextSelected extends StorageTypeSelectorEvent {
  const StorageTypeSelectorNextSelected();
}

final class StorageTypeSelectorSelectingCanceled
    extends StorageTypeSelectorEvent {
  /// on cancel pressed
  const StorageTypeSelectorSelectingCanceled();
}

final class StorageTypeSelectorSelectingCompleted
    extends StorageTypeSelectorEvent {
  /// on confirm pressed
  const StorageTypeSelectorSelectingCompleted([this.callback]);

  /// called with selected storage type
  final void Function(StorageType)? callback;
}
