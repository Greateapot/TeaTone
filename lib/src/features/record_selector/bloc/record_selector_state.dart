part of 'record_selector_bloc.dart';

sealed class RecordSelectorState extends Equatable {
  const RecordSelectorState();

  @override
  List<Object?> get props => [];
}

final class RecordSelectorInitial extends RecordSelectorState {
  /// Состояние для простоя
  /// (чтобы не держать список записей всегда подгруженным).
  const RecordSelectorInitial();
}

final class RecordSelectorStorageIsEmpty extends RecordSelectorState {
  /// Состояние для отображения сообщения об отсутствии записей на накопителе
  const RecordSelectorStorageIsEmpty();
}

final class RecordSelectorProcessing extends RecordSelectorState {
  const RecordSelectorProcessing({
    required this.records,
    required this.selectedIndex,
  });

  final List<Record> records;
  final int selectedIndex;

  RecordSelectorProcessing copyWith(int selectedIndex) =>
      RecordSelectorProcessing(
        records: records,
        selectedIndex: selectedIndex,
      );

  @override
  List<Object?> get props => [records, selectedIndex];
}
