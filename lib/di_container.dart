import 'package:ash_cart/core/services/local/cache_client.dart';
import 'package:ash_cart/features/cart/data/data_source/cart_local_data_source.dart';
import 'package:ash_cart/features/cart/data/data_source/cart_remote_data_source.dart';
import 'package:ash_cart/features/cart/data/repository/cart_repository.dart';
import 'package:ash_cart/features/cart/domain/repository/cart_repository.dart';
import 'package:ash_cart/features/cart/domain/usecase/add_cart_usecase.dart';
import 'package:ash_cart/features/cart/domain/usecase/clear_cart_usecase.dart';
import 'package:ash_cart/features/cart/domain/usecase/get_cart_usecase.dart';
import 'package:ash_cart/features/cart/domain/usecase/order_cart_items_usecase.dart';
import 'package:ash_cart/features/cart/domain/usecase/remove_item_cart_usecase.dart';
import 'package:ash_cart/features/cart/domain/usecase/update_item_cart_usecase.dart';
import 'package:ash_cart/features/cart/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/clear_cart/clear_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/get_cart/get_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/init_product_card/init_product_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/order_cart/order_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/remove_item_cart/remove_item_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/update_item_cart/update_item_cart_cubit.dart';
import 'package:ash_cart/features/products/data/data_source/products_remote_data_source.dart';
import 'package:ash_cart/features/products/data/repository/products_repository_impl.dart';
import 'package:ash_cart/features/products/domain/repository/products_repository.dart';
import 'package:ash_cart/features/products/domain/usecase/get_product_details_usecase.dart';
import 'package:ash_cart/features/products/domain/usecase/get_products_usecase.dart';
import 'package:ash_cart/features/products/presentation/cubit/product_details/product_details_cubit.dart';
import 'package:ash_cart/features/products/presentation/cubit/products/products_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'core/services/network/api_client.dart';
import 'core/services/network/network_info.dart';
import 'package:get_storage/get_storage.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {

  // External
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<PrettyDioLogger>(() => PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true));
  sl.registerLazySingleton<GetStorage>(() => GetStorage());


  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfo(sl<Connectivity>()));
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>(), sl<PrettyDioLogger>()));
  sl.registerLazySingleton<CacheClient>(() => CacheClient(sl<GetStorage>()));

  // Remote Data Source
  sl.registerLazySingleton<ProductsRemoteDataSource>(() => ProductsRemoteDataSourceImpl(sl<ApiClient>()));
  sl.registerLazySingleton<CartRemoteDataSource>(() => CartRemoteDataSourceImpl(sl<ApiClient>()));

  // Local Data Source
  sl.registerLazySingleton<CartLocalDataSource>(() => CartLocalDataSourceImpl(sl<CacheClient>()));

  // Repository
  sl.registerLazySingleton<ProductsRepository>(() => ProductsRepositoryImpl(sl<ProductsRemoteDataSource>()));
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl<CartLocalDataSource>(),sl<CartRemoteDataSource>(),));

  // Use Case
  sl.registerLazySingleton(() => GetProductsUseCase(sl<ProductsRepository>()));
  sl.registerLazySingleton(() => GetProductDetailsUseCase(sl<ProductsRepository>()));
  sl.registerLazySingleton(() => GetCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => RemoveItemCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => AddCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => UpdateItemCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => OrderCartItemsUseCase(sl<CartRepository>()));

  // Cubit
  sl.registerFactory(() => ProductsCubit(sl<GetProductsUseCase>()));
  sl.registerFactory(() => ProductDetailsCubit(sl<GetProductDetailsUseCase>()));
  sl.registerFactory(() => AddToCartCubit(sl<AddCartUseCase>()));
  sl.registerFactory(() => ClearCartCubit(sl<ClearCartUseCase>()));
  sl.registerFactory(() => RemoveItemCubit(sl<RemoveItemCartUseCase>()));
  sl.registerFactory(() => GetCartCubit(sl<GetCartUseCase>()));
  sl.registerFactory(() => UpdateItemCartCubit(sl<UpdateItemCartUseCase>()));
  sl.registerFactory(() => OrderCartCubit(sl<OrderCartItemsUseCase>()));
  sl.registerFactory(() => InitProductCartCubit());
  

}
