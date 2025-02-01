part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class ToggleImageContainer extends HomeEvent {}

class PickOverlayImage extends HomeEvent {}

class ClearOverlayImage extends HomeEvent {}

class PickMoreImages extends HomeEvent {}

class ListReorderEvent extends HomeEvent {
  final int? old;

  int? newValue;

  ListReorderEvent({this.old, this.newValue});
}

class HomeButtonClick extends HomeEvent {}

class ClearPassword extends HomeEvent {}

class SetPassword extends HomeEvent {
  final String password;
  SetPassword({required this.password});
}

class RemoveImageFromList extends HomeEvent {
  final int position;

  RemoveImageFromList({required this.position});
}

class Reset extends HomeEvent {}
