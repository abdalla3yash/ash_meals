
import 'package:ash_cart/features/cart/data/model/cart_item_model.dart';
import 'package:ash_cart/features/cart/domain/usecase/add_cart_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  final AddCartUseCase useCase;
  AddToCartCubit(this.useCase) : super(AddToCartInitial());

  void addToCart(CartItemModel item) async {
    emit(AddToCartLoading());
    try{
      await useCase(item); 
      emit(AddToCartLoaded());
    } catch(e){
      emit(AddToCartError('Something went Wrong! $e'));
    }   
  }

}