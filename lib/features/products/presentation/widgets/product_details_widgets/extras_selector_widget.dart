

import 'package:ash_cart/core/resources/resources.dart';
import 'package:ash_cart/features/cart/presentation/cubit/init_product_card/init_product_cart_cubit.dart';
import 'package:ash_cart/features/products/domain/entity/product_details_entity.dart';
import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ExtrasSelectorWidget extends StatefulWidget {
  final List<ExtraItemEntity> entities;
  final String price;

  const ExtrasSelectorWidget({super.key,required this.entities, required this.price});

  @override
  State<ExtrasSelectorWidget> createState() => _ExtrasSelectorWidgetState();
}

class _ExtrasSelectorWidgetState extends State<ExtrasSelectorWidget> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitProductCartCubit,InitProductCartState>(
      builder: (context, state) => ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.entities.length,
        itemBuilder: (context, index) {
          final item = widget.entities[index];
          bool isSelected = state.selectedExtras.contains(item);
      
          return GestureDetector(
            onTap: () => context.read<InitProductCartCubit>().toggleExtras(item,double.tryParse(widget.price.toString())!),
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
                      item.name.isEmpty == true ? "Extra #${index + 1}" : item.name,
                      style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w700, color: AppColors.black),
                    ),
                  ),
                  Text(
                    '${item.price.toStringAsFixed(2)} EGP',
                    style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w700, color: AppColors.black),
                  ).paddingHorizontal(8.w),
                  Icon(
                    isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                    color: isSelected ? AppColors.primary : AppColors.grey,
                  ),
                ],
              ),
            ).paddingSymmetric(vertical: 4.h),
          );
        },
      ),
    );
  }
}
