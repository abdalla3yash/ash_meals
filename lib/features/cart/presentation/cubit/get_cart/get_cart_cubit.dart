
import 'package:ash_cart/features/cart/data/model/cart_item_model.dart';
import 'package:ash_cart/features/cart/domain/usecase/get_cart_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  final GetCartUseCase useCase;
  GetCartCubit(this.useCase) : super(GetCartInitial());

  void getCart() async {
    emit(GetCartLoading());
    try{
      final result =  useCase(); 
      emit(GetCartLoaded(result));
    } catch(e){
      emit(GetCartError('Something went Wrong! $e'));
    }   
  }
}