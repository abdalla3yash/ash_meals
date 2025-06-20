
import 'package:ash_cart/features/products/domain/entity/product_entity.dart';
import 'package:equatable/equatable.dart';

class ProductsEntity extends Equatable {
  final int id;
  final String name;
  final String backgroundImage;
  final String image;
  final List<ProductEntity> products;

  const ProductsEntity({
    required this.id,
    required this.name,
    required this.backgroundImage,
    required this.image,
    required this.products,
  });
  
  @override
  List<Object?> get props => [
    id,
    name,
    backgroundImage,
    image,
    products,
  ];
}
