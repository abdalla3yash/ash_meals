part of "./products_cubit.dart";


abstract class ProductsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final ProductsEntity data;
  ProductsLoaded(this.data);
  @override
  List<Object?> get props => [data];
}

class ProductsError extends ProductsState {
  final String message;

  ProductsError(this.message);
  @override
  List<Object?> get props => [message];
}