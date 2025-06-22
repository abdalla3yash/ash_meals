import 'package:ash_cart/core/resources/resources.dart';
import 'package:ash_cart/core/view/components/tap_effect.dart';
import 'package:ash_cart/core/view/widgets/cusom_add_remove_widget.dart';
import 'package:ash_cart/features/cart/presentation/cubit/init_product_card/init_product_cart_cubit.dart';
import 'package:ash_cart/features/products/domain/entity/products_entity.dart';
import 'package:ash_cart/features/products/presentation/cubit/product_details/product_details_cubit.dart';
import 'package:ash_cart/features/products/presentation/view/product_details_bottomsheet.dart';
import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity entity;
  const ProductCard({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onClick: (){
        context.read<ProductDetailsCubit>().fetchProduct(entity.id.toString());
        context.read<InitProductCartCubit>().resetValues();
       productDetailsBottomSheet(context, entity.id.toString());
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, offset: const Offset(0, 8), blurRadius: 20)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child:CachedNetworkImage(
                    imageUrl: entity.image,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                    height: 120.h,
                    progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress, color: AppColors.primary, strokeWidth: 2)),
                    errorWidget: (context, url, error) => Image.asset(AppImages.imgLogo, fit: BoxFit.cover),
                  ),
                ),
      
                Positioned(top: 8, right: 8, child: const Icon(Icons.favorite_border, color: AppColors.primary))
              ],
            ),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entity.name, style: Theme.of(context).textTheme.bodyMedium?.medium),
                  4.heightBox,
                  Text(entity.description, style: Theme.of(context).textTheme.bodyMedium?.regular.copyWith(color: Colors.black54)),
                ],
              ),
            ),
      
            const Spacer(),
      
            SizedBox(
              width: double.maxFinite,
              height: 52.h,
              child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 36.h,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: AppColors.lightGrey, blurRadius: 2, spreadRadius: 2, offset: Offset(0, -1))],
                    ),
                    child: Text(
                      entity.price == 0 ? "price upon selection" : "\$${entity.price}",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.irishGrover(color: AppColors.primary,fontSize: entity.price == 0 ? 14.sp : 22.sp)
                    ),
                  ),
      
                  Positioned(
                    top: 0,
                    right: 8,
                    child: CustomAddRemoveWidget(icon: Icons.add, onTap: (){}) 
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

