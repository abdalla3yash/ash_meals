import 'package:ash_cart/features/cart/domain/repository/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository repository;
  ClearCartUseCase(this.repository);

  Future<void> call() =>  repository.clearCart();  
}