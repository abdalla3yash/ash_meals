import 'package:ash_cart/features/products/domain/entity/product_details_entity.dart';
import 'package:ash_cart/features/products/domain/repository/products_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductDetailsUseCase {
  final ProductsRepository repository;
  GetProductDetailsUseCase(this.repository);

  Future<Either<String, ProductDetailsEntity>> call(String productId) async => await repository.fetchProductDetails(productId);  
}