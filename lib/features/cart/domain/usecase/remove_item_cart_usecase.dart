// ignore_for_file: file_names

import 'package:ash_cart/features/cart/domain/repository/cart_repository.dart';

class RemoveItemCartUseCase {
  final CartRepository repository;
  RemoveItemCartUseCase(this.repository);

  Future<void> call(String productId) =>  repository.removeItem(productId);  
}