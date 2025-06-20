import 'package:ash_cart/core/navigation/navigation_services.dart';
import 'package:ash_cart/core/navigation/routes.dart';
import 'package:ash_cart/core/resources/app_colors.dart';
import 'package:ash_cart/core/view/components/empty_component.dart';
import 'package:ash_cart/core/view/components/error_component.dart';
import 'package:ash_cart/core/view/widgets/loading_spinner.dart';
import 'package:ash_cart/features/products/presentation/cubit/products/products_cubit.dart';
import 'package:ash_cart/features/products/presentation/widgets/product_card.dart';
import 'package:ash_cart/features/products/presentation/widgets/products_topbar_widget.dart';
import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  @override
  void initState() {
    context.read<ProductsCubit>().fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<ProductsCubit>().fetchProducts(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton.small(
          backgroundColor: AppColors.primary,
          shape: const CircleBorder(),
          onPressed: () =>NavigationService.push(Routes.cartScreen),
          child: Icon(Icons.shopping_cart, color: Colors.white),
        ),
      
        body: SafeArea(
          child: BlocBuilder<ProductsCubit,ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return LoadingSpinner();
              } else if (state is ProductsError) {
                return ErrorComponent(message: state.message, onRetry: ()=> context.read<ProductsCubit>().fetchProducts());
              } else if (state is ProductsLoaded) {
                return Column(
                  children: [
                    ProductsTopBarWidget(entity: state.data),
                    12.heightBox,
                    Expanded(
                      child: GridView.builder(
                        itemCount: state.data.products.length,
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,  crossAxisSpacing: 16.w, mainAxisSpacing: 16.h, childAspectRatio: 0.75),
                        itemBuilder: (context, index) =>ProductCard(entity: state.data.products[index]),
                      ),
                    ),
                  ],
                );
              }
              return EmptyComponent();
            },
          ),
        ),
      ),
    );
  }
}