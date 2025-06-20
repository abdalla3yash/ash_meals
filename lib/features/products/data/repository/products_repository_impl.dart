import 'package:ash_cart/core/base/api_response.dart';
import 'package:ash_cart/features/products/data/data_source/products_remote_data_source.dart';
import 'package:ash_cart/features/products/data/model/products_model.dart';
import 'package:ash_cart/features/products/domain/entity/products_entity.dart';
import 'package:ash_cart/features/products/domain/repository/products_repository.dart';
import 'package:dartz/dartz.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;
  ProductsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, ProductsEntity>> fetchProducts() async {
    try {
     final ApiResponse apiResponse = await remoteDataSource.fetchProducts();
      ProductsEntity data = ProductsModel.fromJson(apiResponse.data['data']); 
      return Right(data);
    } catch (e) {
        return Left(e.toString());
    }
  }
}