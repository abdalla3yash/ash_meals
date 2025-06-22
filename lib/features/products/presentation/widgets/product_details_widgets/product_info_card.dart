import 'package:ash_cart/core/resources/resources.dart';
import 'package:ash_cart/core/view/widgets/cusom_add_remove_widget.dart';
import 'package:ash_cart/features/cart/presentation/cubit/init_product_card/init_product_cart_cubit.dart';
import 'package:ash_cart/features/products/domain/entity/product_details_entity.dart';
import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInfoCard extends StatelessWidget {
  final ProductDetailsEntity entity;
  const ProductInfoCard({super.key,required this.entity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 150.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.white,
        boxShadow: [BoxShadow(color: AppColors.lightGrey, blurRadius: 2, spreadRadius: 2, offset: Offset(1, -1))],
      ),
      child: Row(
        children: [
          8.widthBox,
          SizedBox(
            width: 140.h,
            height: 140.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: entity.image,
                fit: BoxFit.cover,
                progressIndicatorBuilder:(context, url, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress, color: AppColors.primary, strokeWidth: 2)),
                errorWidget: (context, url, error) => Image.asset(AppImages.imgLogo),
              ),
            ),
          ),
          8.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                8.heightBox,
                Text(entity.name, style: Theme.of(context).textTheme.bodyLarge?.medium),
                4.heightBox,
                Text(entity.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium?.regular),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("${entity.priceBeforeDiscount} EGP", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.hintTextColor, decoration: TextDecoration.lineThrough)),
                        Text( "${entity.price} EGP", style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    24.widthBox,
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomAddRemoveWidget(
                            icon: Icons.remove,
                            onTap: () => context.read<InitProductCartCubit>().decrementQuantity(double.tryParse(entity.price.toString())!),
                            size: 32,
                          ),
                          BlocBuilder<InitProductCartCubit,InitProductCartState>(builder:(context, state) => Text( state.quentity.toString(), style: Theme.of(context).textTheme.bodySmall)),
                          CustomAddRemoveWidget(
                            icon: Icons.add,
                            onTap: () => context.read<InitProductCartCubit>().incrementQuantity(double.tryParse(entity.price.toString())!),
                            size: 32,
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 8.w),
                    ),
                  ],
                ),
                8.heightBox,
              ],
            ),
          ),
          8.widthBox,
        ],
      ),
    );
  }
}