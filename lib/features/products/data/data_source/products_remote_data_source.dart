import 'package:ash_cart/core/base/api_response.dart';
import 'package:ash_cart/core/services/network/api_client.dart';
import 'package:ash_cart/core/services/network/endpoints.dart';

abstract class ProductsRemoteDataSource {
  Future<ApiResponse> fetchProducts();
  Future<ApiResponse> fetchProductDetails(String productId);
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ApiClient _apiClient;

  ProductsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResponse> fetchProducts() async {
    try {
      final response = await _apiClient.get(url: EndPoints.productsApi);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  @override
  Future<ApiResponse> fetchProductDetails(String productId) async {
    try {
      final response = await _apiClient.get(url: "${EndPoints.productDetailsApi}/$productId");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }
}
