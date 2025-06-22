
import 'package:ash_cart/features/products/domain/entity/product_details_entity.dart';
import 'package:ash_cart/features/products/domain/usecase/get_product_details_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase useCase;
  ProductDetailsCubit(this.useCase) : super(ProductDetailsInitial());

  void fetchProduct(String productId) async {
    emit(ProductDetailsLoading());
    final result = await useCase(productId); 
    result.fold(
      (error) => emit(ProductDetailsError(error)),
      (data) => emit(ProductDetailsLoaded(data)),
    );
  }

}