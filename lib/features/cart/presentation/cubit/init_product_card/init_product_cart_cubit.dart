
import 'package:ash_cart/core/utils/alerts.dart';
import 'package:ash_cart/features/cart/domain/parameter/salad_parameter.dart';
import 'package:ash_cart/features/products/domain/entity/product_details_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'init_product_cart_state.dart';

class InitProductCartCubit extends Cubit<InitProductCartState> {
  InitProductCartCubit() : super(InitProductCartState());
  
  void incrementQuantity(double productPrice) {
    emit(state.copyWith(quentity: state.quentity + 1));
    calculateNumbersOfSalad();
    calculateTotalPrice(productPrice);
  }

 void decrementQuantity(double productPrice) {
    if (state.quentity > 1) {
      emit(state.copyWith(quentity: state.quentity - 1));
      calculateNumbersOfSalad();
      calculateTotalPrice(productPrice);
    }
  }

  void selectWeight(WeightEntity entity,double productPrice) {
    emit(state.copyWith(selectedWeight: entity));
    calculateNumbersOfSalad();
    calculateTotalPrice(productPrice);
  }

  void calculateNumbersOfSalad() {
    final baseSalad = state.selectedWeight?.numberOfSalad ?? 0;
    final totalSalad = state.quentity * baseSalad;
    emit(state.copyWith(saladNumbers: totalSalad));
  }

  void incrementSalad(SaladParameter salad,double productPrice) {
    final updatedList = List<SaladParameter>.from(state.selectedSalads);
    final index = updatedList.indexWhere((s) => s.id == salad.id);

    final totalSelectedSalads = updatedList.fold<int>(0, (sum, item) => sum + item.quentity);

    if (totalSelectedSalads >= state.saladNumbers) {
      if(state.saladNumbers == 0){
        Alerts.showToast('please Select Weight First');
      } else {
        Alerts.showToast('you reach maximum of Addition #${state.saladNumbers} Weights');
      }
      return; 
    }

    if (index != -1) {
      updatedList[index] = updatedList[index].copyWith(quentity: updatedList[index].quentity + 1);
    } else {
      updatedList.add(salad.copyWith(quentity: 1));
    }
    emit(state.copyWith(selectedSalads: updatedList));
    calculateTotalPrice(productPrice);
  }

  void decrementSalad(SaladParameter salad,double productPrice) {
    final updatedList = List<SaladParameter>.from(state.selectedSalads);
    final index = updatedList.indexWhere((s) => s.id == salad.id);

    if (index != -1 && updatedList[index].quentity > 0) {
      updatedList[index].quentity -= 1;
      emit(state.copyWith(selectedSalads: updatedList));
      calculateTotalPrice(productPrice);
    }
  }

  void toggleExtras(ExtraItemEntity entity,double productPrice) {
    final updatedList = List<ExtraItemEntity>.from(state.selectedExtras);
    final index = updatedList.indexWhere((e) => e.id == entity.id);

    if (index != -1) {
      updatedList.removeAt(index);
    } else {
      updatedList.add(entity);
    }
    emit(state.copyWith(selectedExtras: updatedList));
    calculateTotalPrice(productPrice);
  }

  void calculateTotalPrice(double productPrice) {
    final quantity = state.quentity;
    final basePrice = productPrice * quantity;
    final weightPrice = state.selectedWeight?.price ?? 0;
    final extrasTotal = state.selectedExtras.fold<double>(0,(sum, e) => sum + (e.price));
    final saladsTotal = state.selectedSalads.fold<double>(0,(sum, s) => sum + (s.price * s.quentity));

    emit(state.copyWith(total: basePrice + weightPrice + extrasTotal + saladsTotal));
  }

  void resetValues(){
    emit(InitProductCartState(quentity: 1,saladNumbers: 0,selectedExtras: const [],selectedSalads: const [],selectedWeight: null,total: 0.0,notes: ''));
  }

  void setAllValues({
    String? message,
    int? quentity,
    WeightEntity? selectedWeight,
    int? saladNumbers,
    List<SaladParameter>? selectedSalads,
    List<ExtraItemEntity>? selectedExtras,
    double? total,
    String? notes,
  }) {
    emit(
      InitProductCartState(
        message: message ?? state.message,
        quentity: quentity ?? state.quentity,
        selectedWeight: selectedWeight ?? state.selectedWeight,
        saladNumbers: saladNumbers ?? state.saladNumbers,
        selectedSalads: selectedSalads ?? state.selectedSalads,
        selectedExtras: selectedExtras ?? state.selectedExtras,
        total: total ?? state.total,
        notes: notes ?? state.notes,
      ),
    );
  }

}
