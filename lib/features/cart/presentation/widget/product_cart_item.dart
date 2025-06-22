import 'package:ash_cart/core/resources/resources.dart';
import 'package:ash_cart/core/utils/alerts.dart';
import 'package:ash_cart/core/view/components/tap_effect.dart';
import 'package:ash_cart/core/view/widgets/cusom_add_remove_widget.dart';
import 'package:ash_cart/features/cart/data/model/cart_item_model.dart';
import 'package:ash_cart/features/cart/presentation/cubit/get_cart/get_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/init_product_card/init_product_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/remove_item_cart/remove_item_cubit.dart';
import 'package:ash_cart/features/cart/presentation/view/edit_product_cart_bottomsheet.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCartItem extends StatefulWidget {
  final CartItemModel model;
  const ProductCartItem({super.key,required this.model});

  @override
  State<ProductCartItem> createState() => _ProductCartItemState();
}

class _ProductCartItemState extends State<ProductCartItem> {
  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onClick: (){
        context.read<InitProductCartCubit>().resetValues();
        context.read<InitProductCartCubit>().setAllValues(
          quentity: widget.model.quentitiy,
          selectedWeight: widget.model.selectedWeight,
          saladNumbers: widget.model.saladNumbers,
          selectedSalads: widget.model.selectedSalads,
          selectedExtras: widget.model.selectedExtras,
          total: widget.model.total,
          notes: widget.model.notes,
        );

        editproductCartBottomSheet(context, widget.model);
      },
      child: Container(
        width: double.maxFinite,
        height: 170.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r),color: AppColors.white, boxShadow: [BoxShadow(color: AppColors.lightGrey, blurRadius: 2, spreadRadius: 2, offset: Offset(1, -1))],),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 150.h,
              height: 150.h,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(12.r),
                    child: CachedNetworkImage(
                      imageUrl: widget.model.productmodel!.image,
                      fit: BoxFit.cover,
                      width: 150.h,
                      height: 150.h,
                      progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress, color: AppColors.primary, strokeWidth: 2)),
                      errorWidget: (context, url, error) => Image.asset(AppImages.imgLogo, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(top: 4,left: 4,
                    child: BlocConsumer<RemoveItemCubit,RemoveItemState>(
                      builder: (context, state) => IconButton(onPressed: ()=>context.read<RemoveItemCubit>().removeItem(widget.model.productmodel!.id.toString()), icon: Icon(Icons.delete_forever,color: AppColors.secandry,size: 32.sp,)), 
                      listener: (context, state) {
                        if(state is RemoveItemError)Alerts.showToast(state.message);
                        if(state is RemoveItemLoaded) context.read<GetCartCubit>().getCart();
                      },
                    ),
                  )
                ],
              ),
            ),

            4.widthBox,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.model.productmodel!.name, style: Theme.of(context).textTheme.bodyLarge?.medium),
                  Text(widget.model.productmodel!.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium?.regular),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text( "Weight:", style: Theme.of(context).textTheme.bodySmall?.medium),
                      Text(" ${widget.model.selectedWeight?.name ?? "N/A"}", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.hintTextColor)),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text( "Salads:", style: Theme.of(context).textTheme.bodySmall?.medium),
                      Text(" ${widget.model.selectedSalads.length} Items", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.hintTextColor)),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text( "Extra:", style: Theme.of(context).textTheme.bodySmall?.medium),
                      Text(" ${widget.model.selectedExtras.length} Extras", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.hintTextColor)),
                    ],
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text( "${widget.model.total} EGP", style: Theme.of(context).textTheme.bodySmall?.medium),
                      Icon(Icons.edit_note,color: AppColors.primary,size: 32.sp,),
                      8.widthBox,
                    ],
                  ),
                  8.heightBox,
                ],
              ).paddingSymmetric(horizontal: 8.w,vertical: 8.h),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomAddRemoveWidget(icon: Icons.add, onTap: (){}), 
                Text(widget.model.quentitiy.toString()),
                CustomAddRemoveWidget(icon: Icons.remove, onTap: (){}) ,
                8.heightBox
              ],
            ),
            8.widthBox,
          ],
        ),
      ).paddingSymmetric(horizontal: 16.w),
    );
  }
}