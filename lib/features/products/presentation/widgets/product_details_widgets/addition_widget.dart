import 'package:ash_cart/core/resources/resources.dart';
import 'package:ash_cart/core/view/widgets/cusom_add_remove_widget.dart';
import 'package:ash_cart/features/cart/domain/parameter/salad_parameter.dart';
import 'package:ash_cart/features/cart/presentation/cubit/init_product_card/init_product_cart_cubit.dart';
import 'package:ash_cart/features/products/domain/entity/product_details_entity.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdditionWidget extends StatefulWidget {
  final List<SaladEntity> entities;
  final String price;
  const AdditionWidget({super.key,required this.entities,required this.price});

  @override
  State<AdditionWidget> createState() => _AdditionWidgetState();
}
class _AdditionWidgetState extends State<AdditionWidget> {
 


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitProductCartCubit,InitProductCartState>(
      
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          8.heightBox,
          Text("Extra (Select ${state.saladNumbers});", style: Theme.of(context).textTheme.bodyMedium?.medium),          
          4.heightBox,
          
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.entities.length,
            itemBuilder: (context, index) {
              final salad = widget.entities[index];
              final currentSalad = state.selectedSalads.firstWhere(
                (s) => s.id == salad.id,
                orElse: () => SaladParameter(id: salad.id, name: salad.name, price: salad.price, image: salad.image),
              );

              return Container(
                height: 100.h,
                margin: EdgeInsets.symmetric(vertical: 4.h),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: AppColors.white, boxShadow: [BoxShadow(color: AppColors.lightGrey, blurRadius: 2, spreadRadius: 2, offset: Offset(1, -1))]),
                child: Row(
                  children: [
                    8.widthBox,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CachedNetworkImage(
                        imageUrl: salad.image,
                        width: 90.h,
                        height: 90.h,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress, color: AppColors.primary, strokeWidth: 2)),
                        errorWidget: (context, url, error) => Image.asset(AppImages.imgLogo, fit: BoxFit.cover),
                      ),
                    ),
                    8.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          8.heightBox,
                          Text(salad.name.isNotEmpty == true ? salad.name : "Addition #${index + 1}", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.sp)),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${salad.price} EGP", style: Theme.of(context).textTheme.bodySmall),
                              Row(
                                children: [
                                  CustomAddRemoveWidget(
                                    icon: Icons.remove,
                                    onTap: () => context.read<InitProductCartCubit>().decrementSalad(currentSalad,double.tryParse(widget.price.toString())!),
                                    size: 32,
                                  ),
                                  Text("${currentSalad.quentity}", style: Theme.of(context).textTheme.bodySmall).paddingSymmetric(horizontal: 8),
                                  CustomAddRemoveWidget(
                                    icon: Icons.add,
                                    onTap: () => context.read<InitProductCartCubit>().incrementSalad(currentSalad,double.tryParse(widget.price.toString())!),
                                    size: 32,
                                  ),
                                ],
                              )
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
            },
          ),
        ],
      ),
    );
  }
}
