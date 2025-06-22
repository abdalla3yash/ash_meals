// ignore_for_file: must_be_immutable

part of "order_cart_cubit.dart";

abstract class OrderCartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderCartInitial extends OrderCartState {}

class OrderCartLoading extends OrderCartState {
  final double progress; 

  OrderCartLoading(this.progress);

  @override
  List<Object?> get props => [progress];
}

class OrderCartLoaded extends OrderCartState {
  dynamic jsonResponse;
  OrderCartLoaded(this.jsonResponse);
  @override
  List<Object?> get props => [jsonResponse];
}

class OrderCartError extends OrderCartState {
  final String message;

  OrderCartError(this.message);

  @override
  List<Object?> get props => [message];
}
