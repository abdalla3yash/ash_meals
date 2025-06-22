import 'package:ash_cart/core/base/api_response.dart';
import 'package:ash_cart/core/services/network/api_client.dart';
import 'package:ash_cart/core/services/network/endpoints.dart';
import 'package:ash_cart/features/cart/domain/parameter/order_cart_parameters.dart';
import 'package:dio/dio.dart';

abstract class CartRemoteDataSource {
  Future<ApiResponse> orderCartItems(OrderCartParameters params,{required ProgressCallback onSendProgress}) ;
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiClient _apiClient;

  CartRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResponse> orderCartItems(OrderCartParameters params,{required ProgressCallback onSendProgress}) async {
    try {
      final response = await _apiClient.post(url: EndPoints.orderCartItemsApi,requestBody: await params.formData,onSendProgress: onSendProgress);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }
}
