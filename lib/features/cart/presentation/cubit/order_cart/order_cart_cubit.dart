import 'package:ash_cart/features/cart/domain/parameter/order_cart_parameters.dart';
import 'package:ash_cart/features/cart/domain/usecase/order_cart_items_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_cart_state.dart';

class OrderCartCubit extends Cubit<OrderCartState> {
  final OrderCartItemsUseCase useCase;
  OrderCartCubit(this.useCase) : super(OrderCartInitial());

  void orderCart(OrderCartParameters params) async {
    emit(OrderCartLoading(0));

    final result = await useCase(params,onSendProgress: (sent, total) {
      final progress = (sent / total) * 100;
      emit(OrderCartLoading(progress));
    });

    result.fold(
      (error) => emit(OrderCartError(error)),
      (response) => emit(OrderCartLoaded(response)),
    );
  }
}
