// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class ProductDetailsEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String image;
  final bool isSingle;
  final int points;
  final List<ExtraItemEntity> extraItems;
  final List<SaladEntity> salads;
  final List<WeightEntity> weights;
  final int price;
  final int priceBeforeDiscount;
  final int numberOfSalad;

  const ProductDetailsEntity({
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

  factory ProductDetailsEntity.fromJson(Map<String, dynamic> json) {
    return ProductDetailsEntity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      isSingle: json['is_single'],
      points: json['points'],
      extraItems: (json['extra_items'] as List)
          .map((e) => ExtraItemEntity.fromJson(e))
          .toList(),
      salads: (json['salads'] as List)
          .map((e) => SaladEntity.fromJson(e))
          .toList(),
      weights: (json['weights'] as List)
          .map((e) => WeightEntity.fromJson(e))
          .toList(),
      price: json['price'],
      priceBeforeDiscount: json['price_before_discount'],
      numberOfSalad: json['number_of_salad'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image,
        'is_single': isSingle,
        'points': points,
        'extra_items': extraItems.map((e) => e.toJson()).toList(),
        'salads': salads.map((e) => e.toJson()).toList(),
        'weights': weights.map((e) => e.toJson()).toList(),
        'price': price,
        'price_before_discount': priceBeforeDiscount,
        'number_of_salad': numberOfSalad,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        isSingle,
        points,
        extraItems,
        salads,
        weights,
        price,
        priceBeforeDiscount,
        numberOfSalad,
      ];
}

class ExtraItemEntity extends Equatable {
  final int id;
  final String name;
  final int price;

  const ExtraItemEntity({
    required this.id,
    required this.name,
    required this.price,
  });

  factory ExtraItemEntity.fromJson(Map<String, dynamic> json) {
    return ExtraItemEntity(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
      };

  @override
  List<Object?> get props => [id, name, price];
}

class SaladEntity extends Equatable {
  final int id;
  final String name;
  final int price;
  final String image;

  const SaladEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory SaladEntity.fromJson(Map<String, dynamic> json) {
    return SaladEntity(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'image': image,
      };

  @override
  List<Object?> get props => [id, name, price, image];
}

class WeightEntity extends Equatable {
  final int id;
  final String name;
  final int price;
  final int points;
  final int priceBeforeDiscount;
  final int numberOfSalad;

  const WeightEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.points,
    required this.priceBeforeDiscount,
    required this.numberOfSalad,
  });

  factory WeightEntity.fromJson(Map<String, dynamic> json) {
    return WeightEntity(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      points: json['points'],
      priceBeforeDiscount: json['price_before_discount'],
      numberOfSalad: json['number_of_salad'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'points': points,
        'price_before_discount': priceBeforeDiscount,
        'number_of_salad': numberOfSalad,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        points,
        priceBeforeDiscount,
        numberOfSalad,
      ];
}
