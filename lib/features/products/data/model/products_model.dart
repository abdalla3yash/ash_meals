import 'package:ash_cart/features/products/domain/entity/products_entity.dart';

class ProductsModel extends ProductsEntity {
  final List<ProductModel> productModels;

  ProductsModel({
    required super.id,
    required String? name,
    required String? backgroundImage,
    required String? image,
    required this.productModels,
  }) : super(
         name: name ?? 'Grilled Meat & Chicken',
         backgroundImage: backgroundImage ?? '',
         image: image ?? '',
         products: productModels.map((e) => e.toEntity()).toList(),
       );

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    final rawList = json['products'];
    final List<ProductModel> productsList = (rawList as List?)?.map((item) => ProductModel.fromJson(item)).toList() ?? [];

    return ProductsModel(
      id: json['id'] ?? 0,
      name: json['name'],
      backgroundImage: json['background_image'],
      image: json['image'],
      productModels: productsList,
    );
  }
}

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
      points: json['points'],
    );
  }

  ProductEntity toEntity() => this;
}
