
import 'package:ash_cart/features/cart/data/model/cart_item_model.dart';
import 'package:ash_cart/features/cart/domain/parameter/order_cart_parameters.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class CartRepository {
  Future<void> addItem(CartItemModel item);
  Future<void> removeItem(String productId);
  Future<void> clearCart();
  List<CartItemModel> getItems();
  Future<void> saveCart(List<CartItemModel> items);
  Future<void> updateItem(CartItemModel updatedItem);
  Future<Either<String, dynamic>> orderCartItems(OrderCartParameters params,{required ProgressCallback onSendProgress});

}