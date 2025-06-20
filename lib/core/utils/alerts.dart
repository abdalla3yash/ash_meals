// ignore_for_file: deprecated_member_use

import 'package:ash_cart/core/resources/resources.dart';
import 'package:ash_cart/core/view/components/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Alerts {
  static void showSnackBar(
    BuildContext context,
    String message, {
    bool forError = true,
    Duration duration = const Duration(seconds: 5),
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: forError ? Colors.red : AppColors.primary,
        content: Text(message,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),),
      ),
    );
  }


   static void showToast(
    String message, [
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity toastGravity = ToastGravity.BOTTOM,
  ]) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: toastGravity,
      timeInSecForIosWeb: 3,
      fontSize: 16,
      backgroundColor: AppColors.lightGrey,
      textColor: AppColors.black,
    );
  }

  static void showBottomSheet(
    BuildContext context, {
    required Widget child,
    required bool expandable,
    bool enableDrag = true,
    bool isDismissible = true,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      backgroundColor: AppColors.white.withValues(alpha:0.4),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top:  Radius.circular(32))),
      constraints: BoxConstraints(maxHeight: MediaQueryData.fromView(WidgetsBinding.instance.window).size.height * 0.8),
      builder: (context) => AppBottomSheet( child: child),
    );
  }
}
