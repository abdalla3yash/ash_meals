import 'package:ash_cart/core/resources/resources.dart';
import 'package:ash_cart/features/products/domain/entity/products_entity.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ProductsTopBarWidget extends StatelessWidget {
  final ProductsEntity entity;
  const ProductsTopBarWidget({super.key,required this.entity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 220.h,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 180.h,
            child: Stack(
              children: [
            
                ClipRRect(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
                  child: CachedNetworkImage(
                    imageUrl: entity.backgroundImage,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                    placeholder: (context, url) => Image.asset(AppImages.imgPlaceHolder, fit: BoxFit.cover),
                    errorWidget: (context, url, error) => Image.asset(AppImages.imgLogo, fit: BoxFit.cover),
                  ),
                ),
                
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
                      color: AppColors.overlayColor.withValues(alpha: 0.38),
                    ),
                  ),
                ),
            
                
                Positioned(
                  top: 12,
                  right: 16,
                  left: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 32.h,
                        height: 32.h,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.r),color: AppColors.white),
                        child: Center(child: Image.asset(AppImages.imgLogo).paddingAll(8)),
                      ),
                      SizedBox(width: context.width * 0.35,child: Text(entity.name,textAlign: TextAlign.center,maxLines: 2,style: Theme.of(context).textTheme.headlineSmall?.medium.copyWith(color: AppColors.white))),
                      Container(
                        width: 32.h,
                        height: 32.h,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.r),color: AppColors.white),
                        child: Center(child: Icon(Icons.menu,size: 24.sp,),),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          
          Positioned(
            bottom: 0,
            child: Align(
              child: Material(
                elevation: 8,
                shape: const CircleBorder(),
                shadowColor: AppColors.grey,
                child: Center(
                  child: SizedBox(
                    width: 120.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(64),
                      child: CachedNetworkImage(
                        imageUrl: entity.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Image.asset(AppImages.imgPlaceHolder, fit: BoxFit.cover),
                        errorWidget: (context, url, error) => Image.asset(AppImages.imgLogo, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}