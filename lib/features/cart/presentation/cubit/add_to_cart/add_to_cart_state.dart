part of "add_to_cart_cubit.dart";


abstract class AddToCartState extends Equatable{
  @override
  List<Object?> get props => [];
}

class AddToCartInitial extends AddToCartState {}

class AddToCartLoading extends AddToCartState {}

class AddToCartLoaded extends AddToCartState {
  AddToCartLoaded();
  @override
  List<Object?> get props => [];
}

class AddToCartError extends AddToCartState {
  final String message;

  AddToCartError(this.message);
  @override
  List<Object?> get props => [message];
}