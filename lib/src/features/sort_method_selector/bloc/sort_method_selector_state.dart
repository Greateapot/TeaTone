part of 'sort_method_selector_bloc.dart';

sealed class SortMethodSelectorState extends Equatable {
  const SortMethodSelectorState();

  @override
  List<Object> get props => [];
}

final class SortMethodSelectorInitial extends SortMethodSelectorState {
  const SortMethodSelectorInitial();
}

final class SortMethodSelectorProcessing extends SortMethodSelectorState {
  const SortMethodSelectorProcessing({
    required this.sortMethods,
    required this.currentIndex,
    required this.selectedIndex,
  });

  final List<SortMethod> sortMethods;
  final int currentIndex;
  final int selectedIndex;

  SortMethodSelectorProcessing copyWith(int selectedIndex) =>
      SortMethodSelectorProcessing(
        sortMethods: sortMethods,
        currentIndex: currentIndex,
        selectedIndex: selectedIndex,
      );

  @override
  List<Object> get props => [sortMethods, selectedIndex];
}
