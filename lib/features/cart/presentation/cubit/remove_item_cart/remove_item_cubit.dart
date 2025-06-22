
import 'package:ash_cart/features/cart/domain/usecase/remove_item_cart_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'remove_item_state.dart';

class RemoveItemCubit extends Cubit<RemoveItemState> {
  final RemoveItemCartUseCase useCase;
  RemoveItemCubit(this.useCase) : super(RemoveItemInitial());

  void removeItem(String productId) async {
    emit(RemoveItemLoading());
    try{
      await useCase(productId); 
      emit(RemoveItemLoaded());
    } catch(e){
      emit(RemoveItemError('Something went Wrong! $e'));
    }   
  }

}