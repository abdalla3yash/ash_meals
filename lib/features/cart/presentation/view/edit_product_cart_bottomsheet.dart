import 'dart:developer';

import 'package:ash_cart/core/navigation/navigation_services.dart';
import 'package:ash_cart/core/resources/resources.dart';
import 'package:ash_cart/core/utils/alerts.dart';
import 'package:ash_cart/core/view/widgets/custom_button.dart';
import 'package:ash_cart/core/view/widgets/custom_text_field.dart';
import 'package:ash_cart/core/view/widgets/loading_spinner.dart';
import 'package:ash_cart/features/cart/data/model/cart_item_model.dart';
import 'package:ash_cart/features/cart/presentation/cubit/get_cart/get_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/init_product_card/init_product_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/update_item_cart/update_item_cart_cubit.dart';
import 'package:ash_cart/features/products/presentation/widgets/product_details_widgets/addition_widget.dart';
import 'package:ash_cart/features/products/presentation/widgets/product_details_widgets/extras_selector_widget.dart';
import 'package:ash_cart/features/products/presentation/widgets/product_details_widgets/product_info_card.dart';
import 'package:ash_cart/features/products/presentation/widgets/product_details_widgets/weight_selector_widget.dart';
import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


void editproductCartBottomSheet(BuildContext context,CartItemModel model) {
  Alerts.showBottomSheet(
    context,
    expandable: true,
    child: ProductCartDetails(model:model),
  );
}


class ProductCartDetails extends StatefulWidget {
  final CartItemModel model;
  const ProductCartDetails({super.key,required this.model});

  @override
  State<ProductCartDetails> createState() => _ProductCartDetailsState();
}

class _ProductCartDetailsState extends State<ProductCartDetails> {
  final notesController = TextEditingController();

  @override
  void initState() {
    notesController.text = widget.model.notes;    
    super.initState();
  }
  

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ProductInfoCard(entity: widget.model.productmodel!),

        8.heightBox,
        Text("Weights", style: Theme.of(context).textTheme.bodyMedium?.medium),
        4.heightBox,
        WeightSelectorWidget(entities: widget.model.productmodel?.weights ?? [],price: widget.model.productmodel!.price.toString()),

        AdditionWidget(entities: widget.model.productmodel!.salads,price: widget.model.productmodel!.price.toString()),

        8.heightBox,
        Text("Extras:", style: Theme.of(context).textTheme.bodyMedium?.medium),
        4.heightBox,
        ExtrasSelectorWidget(entities:widget.model.productmodel!.extraItems,price: widget.model.productmodel!.price.toString()),

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
          builder: (context, state) => BlocConsumer<UpdateItemCartCubit,UpdateItemCartState>(
            builder: (context, cartState) {
              return cartState is UpdateItemCartLoading 
              ? LoadingSpinner()
              : CustomButton(
                borderRadius: 12.r,
                color: AppColors.primary,
                height: 42.h,
                onPressed: () {
                  if(widget.model.productmodel!.weights.isNotEmpty && state.selectedWeight == null){
                    Alerts.showToast('please Select Weight');
                    return;
                  }
                  state.notes = notesController.text;
                  final cartItem = CartItemModel(
                    productmodel: widget.model.productmodel,
                    notes: state.notes,
                    quentitiy: state.quentity,
                    saladNumbers: state.saladNumbers,
                    selectedExtras: state.selectedExtras,
                    selectedSalads: state.selectedSalads,
                    selectedWeight: state.selectedWeight,
                    total: state.total
                  );

                  log(cartItem.toString());
                  context.read<UpdateItemCartCubit>().updateItemCart(cartItem);
                },
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Save Changes', style: GoogleFonts.inter(color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                    Text('${state.total} EGP', style: GoogleFonts.inter(color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                  ],
                ).paddingSymmetric(horizontal: 8.w),
              );
            }, 
            listener: (context, cartState) {
              if(cartState is UpdateItemCartError){
                Alerts.showToast(cartState.message);
              }
              if(cartState is UpdateItemCartLoaded){
                Alerts.showToast('Updated Item Cart Success');
                context.read<GetCartCubit>().getCart();
                NavigationService.goBack();
              }
            },
          )
        )
      ],
    ).paddingSymmetric(horizontal: 8.w);
  }
}
