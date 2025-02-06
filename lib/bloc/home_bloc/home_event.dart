part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ChangeMenu extends HomeEvent {
  final String item;

  const ChangeMenu(this.item);

  @override
  List<Object> get props => [
        item,
      ];
}

class OnMenuChanged extends HomeEvent {
  final bool value;

  const OnMenuChanged(this.value);

  @override
  List<Object> get props => [
        value,
      ];
}

class HomeInitial extends HomeEvent {
  const HomeInitial();
}

class OnItemSelect extends HomeEvent {
  final int index;

  const OnItemSelect({
    required this.index,
  });
}

class ItemTap extends HomeEvent {
  final String simId;

  const ItemTap({
    required this.simId,
  });
}
