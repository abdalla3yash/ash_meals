
import 'package:ash_cart/features/products/domain/entity/products_entity.dart';
import 'package:ash_cart/features/products/domain/use_case/get_products_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part './products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUseCase useCase;
  ProductsCubit(this.useCase) : super(ProductsInitial());

  void fetchProducts() async {
    emit(ProductsLoading());
    final result = await useCase(); 
    result.fold(
      (error) => emit(ProductsError(error)),
      (data) => emit(ProductsLoaded(data)),
    );
  }

}