part of "get_cart_cubit.dart";


abstract class GetCartState extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetCartInitial extends GetCartState {}

class GetCartLoading extends GetCartState {}

class GetCartLoaded extends GetCartState {
  final List<CartItemModel> localData;
  GetCartLoaded(this.localData);
  double get totalPrice => localData.fold(0.0, (sum, item) => sum + (item.total));

  @override
  List<Object?> get props => [localData];
}

class GetCartError extends GetCartState {
  final String message;

  GetCartError(this.message);
  @override
  List<Object?> get props => [message];
}