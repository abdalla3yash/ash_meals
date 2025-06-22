import 'dart:developer';

import 'package:ash_cart/core/navigation/navigation_services.dart';
import 'package:ash_cart/core/resources/resources.dart';
import 'package:ash_cart/core/utils/alerts.dart';
import 'package:ash_cart/core/view/components/empty_component.dart';
import 'package:ash_cart/core/view/components/error_component.dart';
import 'package:ash_cart/core/view/widgets/custom_button.dart';
import 'package:ash_cart/core/view/widgets/custom_text_field.dart';
import 'package:ash_cart/core/view/widgets/loading_spinner.dart';
import 'package:ash_cart/features/cart/data/model/cart_item_model.dart';
import 'package:ash_cart/features/cart/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/get_cart/get_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/init_product_card/init_product_cart_cubit.dart';
import 'package:ash_cart/features/products/presentation/cubit/product_details/product_details_cubit.dart';
import 'package:ash_cart/features/products/presentation/widgets/product_details_widgets/addition_widget.dart';
import 'package:ash_cart/features/products/presentation/widgets/product_details_widgets/extras_selector_widget.dart';
import 'package:ash_cart/features/products/presentation/widgets/product_details_widgets/product_info_card.dart';
import 'package:ash_cart/features/products/presentation/widgets/product_details_widgets/weight_selector_widget.dart';
import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


void productDetailsBottomSheet(BuildContext context, String productId) {
  Alerts.showBottomSheet(
    context,
    expandable: true,
    child: ProductDetailsScreen(productId: productId),
  );
}


class ProductDetailsScreen extends StatefulWidget {
  final String productId;
  const ProductDetailsScreen({super.key,required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  
  final notesController = TextEditingController();

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return LoadingSpinner();
        } else if (state is ProductDetailsError) {
          return ErrorComponent(message: state.message, onRetry: () => context.read<ProductDetailsCubit>().fetchProduct(widget.productId));
        } else if (state is ProductDetailsLoaded) {
          final product = state.data;
          context.read<InitProductCartCubit>().calculateTotalPrice(double.tryParse(product.price.toString())!);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductInfoCard(entity: product),

              8.heightBox,
              Text("Weights", style: Theme.of(context).textTheme.bodyMedium?.medium),
              4.heightBox,
              WeightSelectorWidget(entities: product.weights,price: product.price.toString()),

              AdditionWidget(entities: product.salads,price: product.price.toString()),

              8.heightBox,
              Text("Extras:", style: Theme.of(context).textTheme.bodyMedium?.medium),
              4.heightBox,
              ExtrasSelectorWidget(entities:product.extraItems,price: product.price.toString()),

              8.heightBox,
              Text("Notes",  style:  Theme.of(context).textTheme.bodyMedium?.medium),
              4.heightBox,
              CustomTextField(
                maxLine: 3,
                hintText: 'Add Notes',
                borderColor: AppColors.grey.withValues(alpha: 0.1),
                controller: notesController,
              ),

              12.heightBox,
              BlocBuilder<InitProductCartCubit,InitProductCartState>(
                builder: (context, state) => BlocConsumer<AddToCartCubit,AddToCartState>(
                  builder: (context, cartState) {
                    return cartState is AddToCartLoading 
                    ? LoadingSpinner()
                    : CustomButton(
                      borderRadius: 12.r,
                      color: AppColors.primary,
                      height: 42.h,
                      onPressed: () {
                        if(product.weights.isNotEmpty && state.selectedWeight == null){
                          Alerts.showToast('please Select Weight');
                          return;
                        }

                        context.read<GetCartCubit>().getCart();

                        
                        state.notes = notesController.text;
                        final cartItem = CartItemModel(
                          productmodel: product,
                          notes: state.notes,
                          quentitiy: state.quentity,
                          saladNumbers: state.saladNumbers,
                          selectedExtras: state.selectedExtras,
                          selectedSalads: state.selectedSalads,
                          selectedWeight: state.selectedWeight,
                          total: state.total
                        );

                        log(cartItem.toString());
                        context.read<AddToCartCubit>().addToCart(cartItem);
                      },
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Add To Cart', style: GoogleFonts.inter(color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                          Text(
                            '${state.total} EGP',
                            style: GoogleFonts.inter(color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 8.w),
                    );
                  }, 
                  listener: (context, cartState) {
                    if(cartState is AddToCartError){
                      Alerts.showToast(cartState.message);
                    }
                    if(cartState is AddToCartLoaded){
                      Alerts.showToast('Add To Cart');
                      NavigationService.goBack();
                    }
                  },
                )
              )
            ],
          ).paddingSymmetric(horizontal: 8.w);
        }
        return EmptyComponent();
      },
    );
  }
}
