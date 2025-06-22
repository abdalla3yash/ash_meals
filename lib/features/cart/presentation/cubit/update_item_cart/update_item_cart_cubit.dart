
import 'package:ash_cart/features/cart/data/model/cart_item_model.dart';
import 'package:ash_cart/features/cart/domain/usecase/update_item_cart_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_item_cart_state.dart';

class UpdateItemCartCubit extends Cubit<UpdateItemCartState> {
  final UpdateItemCartUseCase useCase;
  UpdateItemCartCubit(this.useCase) : super(UpdateItemCartInitial());

  void updateItemCart(CartItemModel item) async {
    emit(UpdateItemCartLoading());
    try{
      await useCase(item); 
      emit(UpdateItemCartLoaded());
    } catch(e){
      emit(UpdateItemCartError('Something went Wrong! $e'));
    }   
  }

}