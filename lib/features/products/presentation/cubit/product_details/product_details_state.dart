part of "product_details_cubit.dart";



abstract class ProductDetailsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductDetailsEntity data;
  ProductDetailsLoaded(this.data);
  @override
  List<Object?> get props => [data];
}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  ProductDetailsError(this.message);
  @override
  List<Object?> get props => [message];
}