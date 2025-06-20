import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ash_cart/core/view/widgets/custom_button.dart' show CustomButton;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/resources.dart';

class ErrorComponent extends StatelessWidget {
  final String message;
  final Color buttoncolor,textColor;
  final void Function()? onRetry;

  const ErrorComponent({required this.message, required this.onRetry,this.buttoncolor = AppColors.primary,this.textColor = AppColors.black, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            16.heightBox,
            Text(message,style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center),
            16.heightBox,
            CustomButton(text:'Re-try', width: context.width * 0.3, onPressed: onRetry,height: 30.h,color: buttoncolor,textColor: textColor,)
          ],
        ),
      ),
    );
  }
}
