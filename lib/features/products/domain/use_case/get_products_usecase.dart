import 'package:ash_cart/features/products/domain/entity/products_entity.dart';
import 'package:ash_cart/features/products/domain/repository/products_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductsUseCase {
  final ProductsRepository repository;
  GetProductsUseCase(this.repository);

  Future<Either<String, ProductsEntity>> call() async => await repository.fetchProducts();  
}