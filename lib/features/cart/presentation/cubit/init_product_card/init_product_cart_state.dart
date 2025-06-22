part of 'init_product_cart_cubit.dart';

class InitProductCartState {
  final String? message;
  int quentity;
  WeightEntity? selectedWeight;
  int saladNumbers;
  List<SaladParameter> selectedSalads;
  List<ExtraItemEntity> selectedExtras;
  double total;
  String notes;

  InitProductCartState({
    this.message,
    this.quentity = 1,
    this.selectedWeight,
    this.saladNumbers = 0,
    this.selectedSalads = const [],
    this.selectedExtras = const [],
    this.total = 0.0,
    this.notes = '',
  });

  InitProductCartState copyWith({
    String? message,
    int? quentity,
    WeightEntity? selectedWeight,
    int? saladNumbers,
    List<SaladParameter>? selectedSalads,
    List<ExtraItemEntity>? selectedExtras,
    double? total,
    String? notes,
  }) =>
      InitProductCartState(
        message: message ?? this.message,
        quentity: quentity ?? this.quentity,
        selectedWeight: selectedWeight?? this.selectedWeight,
        saladNumbers: saladNumbers ?? this.saladNumbers,
        selectedSalads: selectedSalads ?? this.selectedSalads, 
        selectedExtras: selectedExtras ?? this.selectedExtras,
        total : total ?? this.total,
        notes:notes ?? this.notes,
    );
}
