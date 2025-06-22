import 'package:ash_cart/features/products/domain/entity/product_details_entity.dart';

class ProductDetailsModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final bool isSingle;
  final int points;
  final List<ExtraItemModel> extraItems;
  final List<SaladModel> salads;
  final List<WeightModel> weights;
  final int price;
  final int priceBeforeDiscount;
  final int numberOfSalad;

  const ProductDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.isSingle,
    required this.points,
    required this.extraItems,
    required this.salads,
    required this.weights,
    required this.price,
    required this.priceBeforeDiscount,
    required this.numberOfSalad,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'],
      name: json['name'] ?? 'Meal Name',
      description: json['description'] ?? 'Meal Description',
      image: json['image'] ?? '',
      isSingle: json['is_single'] ?? false,
      points: json['points'] ?? 0,
      extraItems: List<ExtraItemModel>.from(
          (json['extra_items'] ?? []).map((v) => ExtraItemModel.fromJson(v))),
      salads: List<SaladModel>.from(
          (json['salads'] ?? []).map((v) => SaladModel.fromJson(v))),
      weights: List<WeightModel>.from(
          (json['weights'] ?? []).map((v) => WeightModel.fromJson(v))),
      price: json['price'] ?? 0,
      priceBeforeDiscount: json['price_before_discount'] ?? 0,
      numberOfSalad: json['number_of_salad'] ?? 0,
    );
  }

  ProductDetailsEntity toEntity() {
    return ProductDetailsEntity(
      id: id,
      name: name,
      description: description,
      image: image,
      isSingle: isSingle,
      points: points,
      extraItems: extraItems.map((e) => e.toEntity()).toList(),
      salads: salads.map((e) => e.toEntity()).toList(),
      weights: weights.map((e) => e.toEntity()).toList(),
      price: price,
      priceBeforeDiscount: priceBeforeDiscount,
      numberOfSalad: numberOfSalad,
    );
  }
}


class ExtraItemModel {
  final int id;
  final String name;
  final int price;

  ExtraItemModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory ExtraItemModel.fromJson(Map<String, dynamic> json) {
    return ExtraItemModel(
      id: json['id'],
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
    );
  }

  

  ExtraItemEntity toEntity() {
    return ExtraItemEntity(id: id, name: name, price: price);
  }
}

class SaladModel {
  final int id;
  final String name;
  final int price;
  final String image;

  SaladModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory SaladModel.fromJson(Map<String, dynamic> json) {
    return SaladModel(
      id: json['id'],
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      image: json['image'] ?? '',
    );
  }

  SaladEntity toEntity() {
    return SaladEntity(id: id, name: name, price: price, image: image);
  }
}

class WeightModel {
  final int id;
  final String name;
  final int price;
  final int points;
  final int priceBeforeDiscount;
  final int numberOfSalad;

  WeightModel({
    required this.id,
    required this.name,
    required this.price,
    required this.points,
    required this.priceBeforeDiscount,
    required this.numberOfSalad,
  });

  factory WeightModel.fromJson(Map<String, dynamic> json) {
    return WeightModel(
      id: json['id'],
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      points: json['points'] ?? 0,
      priceBeforeDiscount: json['price_before_discount'] ?? 0,
      numberOfSalad: json['number_of_salad'] ?? 0,
    );
  }

  WeightEntity toEntity() {
    return WeightEntity(
      id: id,
      name: name,
      price: price,
      points: points,
      priceBeforeDiscount: priceBeforeDiscount,
      numberOfSalad: numberOfSalad,
    );
  }
}
