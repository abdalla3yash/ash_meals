part of "remove_item_cubit.dart";


abstract class RemoveItemState extends Equatable{
  @override
  List<Object?> get props => [];
}

class RemoveItemInitial extends RemoveItemState {}

class RemoveItemLoading extends RemoveItemState {}

class RemoveItemLoaded extends RemoveItemState {
  RemoveItemLoaded();
  @override
  List<Object?> get props => [];
}

class RemoveItemError extends RemoveItemState {
  final String message;

  RemoveItemError(this.message);
  @override
  List<Object?> get props => [message];
}