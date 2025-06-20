import 'package:ash_cart/features/products/data/data_source/products_remote_data_source.dart';
import 'package:ash_cart/features/products/data/repository/products_repository_impl.dart';
import 'package:ash_cart/features/products/domain/repository/products_repository.dart';
import 'package:ash_cart/features/products/domain/use_case/get_products_usecase.dart';
import 'package:ash_cart/features/products/presentation/cubit/products/products_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'core/services/network/api_client.dart';
import 'core/services/network/network_info.dart';
import 'package:path_provider/path_provider.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  final cartBox = await Hive.openBox('cartBox');

  // External
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<PrettyDioLogger>(() => PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfo(sl<Connectivity>()));
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>(), sl<PrettyDioLogger>()));

  // Data Layer
  sl.registerLazySingleton<ProductsRemoteDataSource>(() => ProductsRemoteDataSourceImpl(sl<ApiClient>()));

  // Repository
  sl.registerLazySingleton<ProductsRepository>(() => ProductsRepositoryImpl(sl<ProductsRemoteDataSource>()));

  // Use Case
  sl.registerLazySingleton(() => GetProductsUseCase(sl<ProductsRepository>()));

  // Cubit
  sl.registerFactory(() => ProductsCubit(sl<GetProductsUseCase>()));
}
