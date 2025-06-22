import 'package:ash_cart/features/cart/data/model/cart_item_model.dart';
import 'package:ash_cart/features/cart/domain/repository/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repository;
  GetCartUseCase(this.repository);

  List<CartItemModel> call() =>  repository.getItems();  
}