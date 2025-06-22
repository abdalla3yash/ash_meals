import 'package:ash_cart/features/cart/data/model/cart_item_model.dart';
import 'package:ash_cart/features/cart/domain/repository/cart_repository.dart';
import 'package:ash_cart/features/products/domain/entity/product_details_entity.dart';


class AddCartUseCase {
  final CartRepository repository;
  AddCartUseCase(this.repository);

  Future<void> call(CartItemModel item) async {
    final localData = repository.getItems();

    final existingItem = localData.firstWhere(
      (e) {
        final sameProduct = e.productmodel?.id == item.productmodel?.id;
        final sameWeight = e.selectedWeight?.id == item.selectedWeight?.id;
        final sameExtras = _compareExtras(e.selectedExtras, item.selectedExtras);
        return sameProduct && sameWeight && sameExtras;
      },
      orElse: () => CartItemModel(), 
    );

    final isExist = existingItem.productmodel != null;

    if (isExist) {
      final updatedItem = existingItem.copyWith(
        quentitiy: (existingItem.quentitiy ?? 0) + (item.quentitiy ?? 0),
        total: (existingItem.total) + (item.total),
      );

      await repository.updateItem(updatedItem);
      return;
    }

    await repository.addItem(item);
  }



  bool _compareExtras(List<ExtraItemEntity> a, List<ExtraItemEntity> b) {
    if (a.length != b.length) return false;

    final sortedA = List.from(a)..sort((x, y) => x.id.compareTo(y.id));
    final sortedB = List.from(b)..sort((x, y) => x.id.compareTo(y.id));

    for (int i = 0; i < sortedA.length; i++) {
      if (sortedA[i].id != sortedB[i].id) return false;
    }

    return true;
  }


}

