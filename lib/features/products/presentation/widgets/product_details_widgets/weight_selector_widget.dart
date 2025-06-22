// ignore_for_file: must_be_immutable
import 'package:ash_cart/core/resources/resources.dart';
import 'package:ash_cart/features/cart/presentation/cubit/init_product_card/init_product_cart_cubit.dart';
import 'package:ash_cart/features/products/domain/entity/product_details_entity.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WeightSelectorWidget extends StatelessWidget {
  String price;
  List<WeightEntity> entities;
  WeightSelectorWidget({super.key, required this.entities,required this.price});

  @override
  Widget build(BuildContext context) {
    final weights = entities;

    return BlocBuilder<InitProductCartCubit,InitProductCartState>(
      builder: (context, state) =>  GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: weights.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 4),
        itemBuilder: (context, index) {

          final item = weights[index];
          bool isSelected = state.selectedWeight?.id == weights[index].id;
          final cubit = context.read<InitProductCartCubit>();
      
          return GestureDetector(
            onTap: () => cubit.selectWeight(item,double.tryParse(price.toString())!),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(fontSize: 11.sp, color: AppColors.black),
                    ),
                  ),
                  Text('${item.price.toString()} EGP', style: GoogleFonts.inter(fontSize: 11.sp, color: AppColors.black)).paddingSymmetric(horizontal: 8.w),
                  Icon(isSelected  == true ? Icons.check_circle : Icons.radio_button_off, color: isSelected == true ? AppColors.primary : AppColors.grey),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
