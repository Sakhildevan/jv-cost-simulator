part of 'simulator_category_bloc.dart';

sealed class SimulatorCategoryEvent extends Equatable {
  const SimulatorCategoryEvent();

  @override
  List<Object> get props => [];
}

final class SimCategoryInit extends SimulatorCategoryEvent {
  const SimCategoryInit({required this.type});
  final String type;
}

final class PageChangeEvent extends SimulatorCategoryEvent {
  final int index;
  const PageChangeEvent({
    required this.index,
  });
}

final class DatePickEvent extends SimulatorCategoryEvent {
  final DateTime date;
  final DatePickerType status;
  const DatePickEvent({
    required this.date,
    required this.status,
  });
}

final class FilterStatusTapEvent extends SimulatorCategoryEvent {
  final SimulatorStatus status;
  const FilterStatusTapEvent({
    required this.status,
  });
}

final class FilterSellCurrTapEvent extends SimulatorCategoryEvent {
  final Currency status;
  const FilterSellCurrTapEvent({
    required this.status,
  });
}

final class ShowOrHideSearch extends SimulatorCategoryEvent {
  final bool showSearch;
  const ShowOrHideSearch({
    required this.showSearch,
  });
}

class OnItemSelect extends SimulatorCategoryEvent {
  final int index;

  const OnItemSelect({
    required this.index,
  });
}

final class FilterSave extends SimulatorCategoryEvent {
  const FilterSave();
}

final class SearchEvent extends SimulatorCategoryEvent {
  const SearchEvent({
    required this.query,
  });
  final String query;
}

class ItemTap extends SimulatorCategoryEvent {
  final String simId;

  const ItemTap({
    required this.simId,
  });
}
