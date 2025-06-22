import 'package:ash_cart/features/cart/data/data_source/cart_local_data_source.dart';
import 'package:ash_cart/features/cart/data/data_source/cart_remote_data_source.dart';
import 'package:ash_cart/features/cart/data/model/cart_item_model.dart';
import 'package:ash_cart/features/cart/domain/parameter/order_cart_parameters.dart';
import 'package:ash_cart/features/cart/domain/repository/cart_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.localDataSource,this.remoteDataSource);

  @override
  Future<void> addItem(CartItemModel item) => localDataSource.addItem(item);

  @override
  Future<void> removeItem(String productId) => localDataSource.removeItem(productId);

  @override
  Future<void> clearCart() => localDataSource.clearCart();

  @override
  List<CartItemModel> getItems() => localDataSource.getCartItems();
  
  @override
  Future<void> saveCart(List<CartItemModel> items) => localDataSource.saveCart(items);
  
  @override
  Future<void> updateItem(CartItemModel updatedItem) => localDataSource.updateItem(updatedItem);

  @override
  Future<Either<String, dynamic>> orderCartItems(OrderCartParameters params, {required ProgressCallback onSendProgress}) async {
     try {
      final result = await remoteDataSource.orderCartItems(params,onSendProgress: onSendProgress);
      return Right(result.response?.data['data']);
    } catch (e) {
      return Left(e.toString());
    }
  }
  
}
