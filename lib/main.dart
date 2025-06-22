import 'package:ash_cart/core/navigation/route_generator.dart';
import 'package:ash_cart/core/services/bloc_observer.dart';
import 'package:ash_cart/core/utils/theme.dart';
import 'package:ash_cart/di_container.dart' as di;
import 'package:ash_cart/features/cart/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/clear_cart/clear_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/get_cart/get_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/init_product_card/init_product_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/order_cart/order_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/remove_item_cart/remove_item_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/update_item_cart/update_item_cart_cubit.dart';
import 'package:ash_cart/features/products/presentation/cubit/product_details/product_details_cubit.dart';
import 'package:ash_cart/features/products/presentation/cubit/products/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'core/navigation/navigation_services.dart';
import 'core/navigation/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await di.init();
  Bloc.observer = MyBlocObserver();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ProductsCubit>()),
        BlocProvider(create: (_) => di.sl<ProductDetailsCubit>()),
        BlocProvider(create: (_) => di.sl<AddToCartCubit>()),
        BlocProvider(create: (_) => di.sl<ClearCartCubit>()),
        BlocProvider(create: (_) => di.sl<RemoveItemCubit>()),
        BlocProvider(create: (_) => di.sl<GetCartCubit>()),
        BlocProvider(create: (_) => di.sl<InitProductCartCubit>()),
        BlocProvider(create: (_) => di.sl<UpdateItemCartCubit>()),
        BlocProvider(create: (_) => di.sl<OrderCartCubit>()),

      ],
      child:  MyApp()
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
          title: 'Ash Meals',
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.mainScreen,
          navigatorKey: NavigationService.navigationKey,
          onGenerateRoute: RouteGenerator.onGenerateRoute,
          builder: (context, child) => child!,
          theme: AppTheme.lightTheme
      ),
    );
  }
}
