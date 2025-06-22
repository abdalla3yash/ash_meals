import 'package:ash_cart/core/resources/app_colors.dart';
import 'package:ash_cart/core/view/components/tap_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAddRemoveWidget extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  final double size;
  const CustomAddRemoveWidget({super.key,required this.icon,required this.onTap,this.size = 30});

  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onClick: onTap,
      child: Container(
        width: size,
        height: size,
        decoration:  BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.r),
          gradient: LinearGradient(colors: [AppColors.primary, AppColors.secandry], begin: Alignment.topLeft, end: Alignment.bottomRight),
          boxShadow: [BoxShadow(color:AppColors.hintTextColor, offset: Offset(0, 1), blurRadius: 8)],
        ),
        child: Center(child: Icon(icon, color: Colors.white, size: 18)),
      ),
    );
  }
}