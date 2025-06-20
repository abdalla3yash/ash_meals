import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ash_cart/core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyComponent extends StatelessWidget {
  final String? image;
  final String? title;
  final String? description;
  const EmptyComponent({super.key,this.description,this.image,this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image != null ? image.toString() :AppImages.imgLogo,width: 64,),
          8.heightBox,
          Text(title ?? "No Data Found!!",textAlign: TextAlign.center,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),).paddingSymmetric(horizontal: 8.w),
          8.heightBox,
          Text(description ?? "",textAlign: TextAlign.center,style: const TextStyle(fontSize: 16,color: AppColors.lightGrey,fontWeight: FontWeight.normal),).paddingSymmetric(horizontal: 8.w),
   
        ],
      ),
    );
  }
}
