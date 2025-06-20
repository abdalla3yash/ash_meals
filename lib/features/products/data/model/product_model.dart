import 'package:ash_cart/features/products/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required String? name,
    required String? description,
    required String? image,
    required super.isSingle,
    required super.price,
    required super.priceBeforeDiscount,
    required super.points,
  }) : super(
        name: name ?? "Name",
        description: description ?? 'Description',
        image: image ?? '',
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'],
      description: json['description'],
      image: json['image'],
      isSingle: json['is_single'] ?? false,
      price: json['price'] ?? 0,
      priceBeforeDiscount: json['price_before_discount'] ?? 0,
      points: json['points'] ,
    );
  }

  ProductEntity toEntity() => this;
}
