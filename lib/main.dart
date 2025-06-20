import 'package:ash_cart/core/navigation/route_generator.dart';
import 'package:ash_cart/core/services/bloc_observer.dart';
import 'package:ash_cart/core/utils/theme.dart';
import 'package:ash_cart/di_container.dart' as di;
import 'package:ash_cart/features/products/presentation/cubit/products/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/navigation/navigation_services.dart';
import 'core/navigation/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = MyBlocObserver();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ProductsCubit>()),
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
