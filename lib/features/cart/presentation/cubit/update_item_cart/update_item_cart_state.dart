part of "update_item_cart_cubit.dart";


abstract class UpdateItemCartState extends Equatable{
  @override
  List<Object?> get props => [];
}

class UpdateItemCartInitial extends UpdateItemCartState {}

class UpdateItemCartLoading extends UpdateItemCartState {}

class UpdateItemCartLoaded extends UpdateItemCartState {
  UpdateItemCartLoaded();
  @override
  List<Object?> get props => [];
}

class UpdateItemCartError extends UpdateItemCartState {
  final String message;

  UpdateItemCartError(this.message);
  @override
  List<Object?> get props => [message];
}