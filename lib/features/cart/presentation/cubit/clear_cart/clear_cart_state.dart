part of "clear_cart_cubit.dart";


abstract class ClearCartState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ClearCartInitial extends ClearCartState {}

class ClearCartLoading extends ClearCartState {}

class ClearCartLoaded extends ClearCartState {
  ClearCartLoaded();
  @override
  List<Object?> get props => [];
}

class ClearCartError extends ClearCartState {
  final String message;

  ClearCartError(this.message);
  @override
  List<Object?> get props => [message];
}