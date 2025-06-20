import 'package:ash_cart/core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? color;
  final Color? textColor;
  final Widget? child;
  final double? height;
  final double? width;
  final double? textHeight;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final bool isOutlined;
  final double? borderRadius;

  const CustomButton({
    super.key,
    this.onPressed,
    this.text = "",
    this.color,
    this.textColor,
    this.child,
    this.width,
    this.height,
    this.textHeight,
    this.padding,
    this.borderRadius,
    this.isOutlined = false,
    this.fontSize ,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            border: isOutlined ? Border.all(color: AppColors.primary) : null,
            color: isOutlined  ? null : onPressed == null ? AppColors.white : color ?? AppColors.primary,
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius ?? 8),),
              padding: height != null ? const EdgeInsets.symmetric(horizontal: 16) : padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: text.isNotEmpty
                ? Center(child: Text(text,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor ?? AppColors.white,fontWeight: FontWeight.w500,fontSize: fontSize ?? 16.sp,fontFamily: 'Poppins')))
                : child,
            ),
          ),
        ),
      ),
    );
  }
}
