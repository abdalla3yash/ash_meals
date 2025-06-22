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
  List<Object?> get props => [id, name, backgroundImage, image, products];
}

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String image;
  final bool isSingle;
  final int price;
  final int priceBeforeDiscount;
  final int points;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.isSingle,
    required this.price,
    required this.priceBeforeDiscount,
    required this.points,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    image,
    isSingle,
    price,
    priceBeforeDiscount,
    points,
  ];
}
