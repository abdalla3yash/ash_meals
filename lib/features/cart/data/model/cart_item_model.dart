import 'package:ash_cart/features/products/domain/entity/product_details_entity.dart';
import 'package:ash_cart/features/cart/domain/parameter/salad_parameter.dart';

class CartItemModel {
  int? quentitiy;
  ProductDetailsEntity? productmodel;

  WeightEntity? selectedWeight;
  int saladNumbers;
  List<SaladParameter> selectedSalads;
  List<ExtraItemEntity> selectedExtras;
  double total;
  String notes;

  CartItemModel({
    this.quentitiy,
    this.productmodel,
    this.selectedWeight,
    this.saladNumbers = 0,
    this.selectedSalads = const [],
    this.selectedExtras = const [],
    this.total = 0.0,
    this.notes = '',
  });

  CartItemModel copyWith({
  int? quentitiy,
  ProductDetailsEntity? productmodel,
  WeightEntity? selectedWeight,
  int? saladNumbers,
  List<SaladParameter>? selectedSalads,
  List<ExtraItemEntity>? selectedExtras,
  double? total,
  String? notes,
}) {
  return CartItemModel(
    quentitiy: quentitiy ?? this.quentitiy,
    productmodel: productmodel ?? this.productmodel,
    selectedWeight: selectedWeight ?? this.selectedWeight,
    saladNumbers: saladNumbers ?? this.saladNumbers,
    selectedSalads: selectedSalads ?? List.from(this.selectedSalads),
    selectedExtras: selectedExtras ?? List.from(this.selectedExtras),
    total: total ?? this.total,
    notes: notes ?? this.notes,
  );
}


  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        quentitiy: json['quentitiy'],
        productmodel: json['productmodel'] != null
            ? ProductDetailsEntity.fromJson(json['productmodel'])
            : null,
        selectedWeight: json['selectedWeight'] != null
            ? WeightEntity.fromJson(json['selectedWeight'])
            : null,
        saladNumbers: json['saladNumbers'] ?? 0,
        selectedSalads: (json['selectedSalads'] as List<dynamic>?)
                ?.map((e) => SaladParameter.fromJson(e))
                .toList() ??
            [],
        selectedExtras: (json['selectedExtras'] as List<dynamic>?)
                ?.map((e) => ExtraItemEntity.fromJson(e))
                .toList() ??
            [],
        total: (json['total'] ?? 0).toDouble(),
        notes: json['notes'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'quentitiy': quentitiy,
        'productmodel': productmodel?.toJson(),
        'selectedWeight': selectedWeight?.toJson(),
        'saladNumbers': saladNumbers,
        'selectedSalads':
            selectedSalads.map((e) => e.toJson()).toList(),
        'selectedExtras':
            selectedExtras.map((e) => e.toJson()).toList(),
        'total': total,
        'notes': notes,
      };
}
