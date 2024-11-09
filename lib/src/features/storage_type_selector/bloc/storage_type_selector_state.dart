part of 'storage_type_selector_bloc.dart';

sealed class StorageTypeSelectorState extends Equatable {
  const StorageTypeSelectorState();

  @override
  List<Object> get props => [];
}

final class StorageTypeSelectorInitial extends StorageTypeSelectorState {
  const StorageTypeSelectorInitial();
}

final class StorageTypeSelectorProcessing extends StorageTypeSelectorState {
  const StorageTypeSelectorProcessing({
    required this.storageTypes,
    required this.currentIndex,
    required this.selectedIndex,
  });

  final List<StorageType> storageTypes;
  final int currentIndex;
  final int selectedIndex;

  StorageTypeSelectorProcessing copyWith(int selectedIndex) =>
      StorageTypeSelectorProcessing(
        storageTypes: storageTypes,
        currentIndex: currentIndex,
        selectedIndex: selectedIndex,
      );

  @override
  List<Object> get props => [storageTypes, selectedIndex];
}
