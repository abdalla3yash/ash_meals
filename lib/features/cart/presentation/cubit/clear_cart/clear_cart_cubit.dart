
import 'package:ash_cart/features/cart/domain/usecase/clear_cart_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'clear_cart_state.dart';

class ClearCartCubit extends Cubit<ClearCartState> {
  final ClearCartUseCase useCase;
  ClearCartCubit(this.useCase) : super(ClearCartInitial());

  void clearCart() async {
    emit(ClearCartLoading());
    try{
      await useCase(); 
      emit(ClearCartLoaded());
    } catch(e){
      emit(ClearCartError('Something went Wrong! $e'));
    }   
  }

}