part of 'record_selector_bloc.dart';

sealed class RecordSelectorState extends Equatable {
  const RecordSelectorState();
  
  @override
  List<Object> get props => [];
}

final class RecordSelectorInitial extends RecordSelectorState {}
