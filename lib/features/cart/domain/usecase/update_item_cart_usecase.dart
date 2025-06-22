// ignore_for_file: file_names

import 'package:ash_cart/features/cart/data/model/cart_item_model.dart';
import 'package:ash_cart/features/cart/domain/repository/cart_repository.dart';

class UpdateItemCartUseCase {
  final CartRepository repository;
  UpdateItemCartUseCase(this.repository);

  Future<void> call(CartItemModel item) =>  repository.updateItem(item);  
}