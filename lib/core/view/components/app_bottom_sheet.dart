import 'package:ash_cart/core/resources/app_colors.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppBottomSheet extends StatelessWidget {
  final Widget child;

  const AppBottomSheet({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4.h,
              width: 100.w,
              decoration: const ShapeDecoration(color: AppColors.primary, shape: StadiumBorder()),
            ),
            16.heightBox,
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
