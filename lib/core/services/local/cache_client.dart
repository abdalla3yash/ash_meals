import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class CacheClient {
  final GetStorage _storage;
  CacheClient(this._storage);

  Future<bool> saveString(String key, String value) async {
    await _storage.write(key, value);
    return true;
  }

  dynamic get(String key) {
    return _storage.read(key);
  }

  Future<bool> removeString(String key) async {
    await _storage.remove(key);
    return true;
  }


  Future<bool> savebool(String key, bool value) async {
    await _storage.write(key, value);
    return true;
  }

  Future<bool> saveList(String key, List<Map<String, dynamic>> list) async {
    final jsonString = jsonEncode(list);
    await _storage.write(key, jsonString);
    return true;
  }

  


  List<Map<String, dynamic>>? getList(String key) {
    final jsonString = _storage.read(key);
    if (jsonString != null) {
      final decoded = jsonDecode(jsonString);
      if (decoded is List) {
        return decoded.cast<Map<String, dynamic>>();
      }
    }
    return null;
  }

  Future<bool> addMapToList(String key, Map<String, dynamic> mapToAdd) async {
    List<Map<String, dynamic>>? currentList = getList(key) ?? [];
    currentList.add(mapToAdd);
    return await saveList(key, currentList);
  }

  Future<bool> deleteItem(String key, Map<String, dynamic> itemToDelete) async {
    List<Map<String, dynamic>>? currentList = getList(key);
    if (currentList != null) {
      currentList.removeWhere((item) => mapEquals(item, itemToDelete));
      await saveList(key, currentList);
      return true;
    }
    return false;
  }

  Future<bool> updateItem(
      String key, int index, Map<String, dynamic> updatedItem) async {
    List<Map<String, dynamic>>? currentList = getList(key);
    if (currentList != null && index >= 0 && index < currentList.length) {
      currentList[index] = updatedItem;
      await saveList(key, currentList);
      return true;
    }
    return false;
  }

  Future<bool> delete(String key) async {
    await _storage.remove(key);
    return true;
  }

  Future<void> deleteAll() async => await _storage.erase();
}
