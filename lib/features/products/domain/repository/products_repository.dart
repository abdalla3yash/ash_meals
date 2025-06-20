import 'package:ash_cart/features/products/domain/entity/products_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductsRepository {
  Future<Either<String,ProductsEntity>> fetchProducts();
}