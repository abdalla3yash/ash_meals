import 'package:ash_cart/features/cart/data/model/cart_item_model.dart';
import 'package:dio/dio.dart';

class OrderCartParameters {
  List<CartItemModel> dataList; 
  OrderCartParameters({required this.dataList});

  Future<FormData> get formData async {
    final Map<String, dynamic> fields = {};

    for (int i = 0; i < dataList.length; i++) {
      final item = dataList[i];
      fields['products[$i][id]'] = item.productmodel?.id;
      fields['products[$i][quantity]'] = item.quentitiy;
      fields['products[$i][notes]'] = item.notes;
      fields['products[$i][price]'] = item.total;
      
      if (item.selectedWeight != null) {
        fields['products[$i][weight_id]'] = item.selectedWeight!.id;
      }

      for (int j = 0; j < item.selectedSalads.length; j++) {
        final salad = item.selectedSalads[j];
        fields['products[$i][salads][$j][id]'] = salad.id;
        fields['products[$i][salads][$j][quantity]'] = salad.quentity;
      }

      for (int j = 0; j < item.selectedExtras.length; j++) {
        final extra = item.selectedExtras[j];
        fields['products[$i][extras][$j][id]'] = extra.id;
      }
    }
    return FormData.fromMap(fields);
  }
}

