// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class SaladParameter extends Equatable {
  final int id;
  final String name;
  final int price;
  final String image;
  int quentity;

  SaladParameter({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quentity = 0,
  });

  SaladParameter copyWith({
    int? id,
    String? name,
    int? price,
    String? image,
    int? quentity,
  }) {
    return SaladParameter(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      quentity: quentity ?? this.quentity,
    );
  }

  factory SaladParameter.fromJson(Map<String, dynamic> json) {
    return SaladParameter(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      quentity: json['quentity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'quentity': quentity,
    };
  }

  @override
  List<Object?> get props => [id, name, price, image, quentity];
}
