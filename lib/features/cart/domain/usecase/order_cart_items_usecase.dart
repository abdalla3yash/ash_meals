import 'package:ash_cart/features/cart/domain/parameter/order_cart_parameters.dart';
import 'package:ash_cart/features/cart/domain/repository/cart_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class OrderCartItemsUseCase {
  final CartRepository repository;
  OrderCartItemsUseCase(this.repository);

  Future<Either<String, dynamic>> call(OrderCartParameters params,{required ProgressCallback onSendProgress}) async => await repository.orderCartItems(params,onSendProgress: onSendProgress);  
}