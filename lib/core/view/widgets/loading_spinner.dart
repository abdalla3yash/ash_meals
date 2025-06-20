import 'package:ash_cart/core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingSpinner extends StatelessWidget {
  final Color color;
  final double size;
  const LoadingSpinner({super.key, this.color = AppColors.primary, this.size = 36});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: color,
        size: size.sp,
      ),
    );
  }
}
