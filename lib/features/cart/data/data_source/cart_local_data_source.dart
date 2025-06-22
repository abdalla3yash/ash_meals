import 'package:ash_cart/core/services/local/cache_client.dart';
import 'package:ash_cart/core/services/local/storage_keys.dart';
import 'package:ash_cart/core/utils/alerts.dart';
import 'package:ash_cart/features/cart/data/model/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<void> addItem(CartItemModel item);
  Future<void> removeItem(String productId);
  Future<void> clearCart();
  List<CartItemModel> getCartItems();
  Future<void> saveCart(List<CartItemModel> items);
  Future<void> updateItem(CartItemModel updatedItem);

}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final CacheClient _cacheClient;

  CartLocalDataSourceImpl(this._cacheClient);

  @override
  Future<void> addItem(CartItemModel item) async {
    final existingList = _cacheClient.getList(StorageKeys.cartProducts) ?? [];
    final mutableList = List<Map<String, dynamic>>.from(existingList); 

    mutableList.add(item.toJson());

    await _cacheClient.saveList(StorageKeys.cartProducts, mutableList);
  }

  @override
  Future<void> updateItem(CartItemModel updatedItem) async {
    final existingList = _cacheClient.getList(StorageKeys.cartProducts) ?? [];
    final mutableList = List<Map<String, dynamic>>.from(existingList);

    final index = mutableList.indexWhere((item) => item['productmodel']['id'] == updatedItem.productmodel?.id);
    if (index != -1) {
      mutableList[index] = updatedItem.toJson();
      await _cacheClient.saveList(StorageKeys.cartProducts, mutableList);
    }
  }



  @override
  Future<void> removeItem(String productId) async {
    try {
      final List<Map<String, dynamic>>? cachedData = _cacheClient.getList(StorageKeys.cartProducts);
      if (cachedData != null) {
        int index = cachedData.indexWhere((item) =>    CartItemModel.fromJson(item).productmodel?.id.toString() == productId);
        cachedData.removeAt(index);
        await _cacheClient.saveList(StorageKeys.cartProducts, cachedData);
      } else {
        return ;
      }
    } on Exception catch (e) {
      Alerts.showToast(e.toString());
      return ;
    }
  }

  @override
  Future<void> clearCart() async {
    await _cacheClient.deleteAll();
  }

  @override
  List<CartItemModel> getCartItems() {
    try {
      final List<Map<String, dynamic>>? cachedData = _cacheClient.getList(StorageKeys.cartProducts);
      if (cachedData != null) {
        final cartData = cachedData.map((item) => CartItemModel.fromJson(item)).toList();
        return cartData;
      } else {
        return const [];
      }
    } on Exception catch (e) {
      Alerts.showToast(e.toString());
      return const [];
    }
  }

  @override
  Future<void> saveCart(List<CartItemModel> items) async {
    final List<Map<String, dynamic>> jsonList = items.map((item) => item.toJson()).toList();
    await _cacheClient.saveList(StorageKeys.cartProducts,jsonList);
  }
}
