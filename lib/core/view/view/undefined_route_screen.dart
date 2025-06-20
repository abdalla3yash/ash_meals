import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/resources.dart';

class UndefinedRouteScreen extends StatefulWidget {
  const UndefinedRouteScreen({super.key});

  @override
  State<UndefinedRouteScreen> createState() => _UndefinedRouteScreenState();
}

class _UndefinedRouteScreenState extends State<UndefinedRouteScreen> {

  var expanded = false;
  final transitionDuration = const Duration(seconds: 1);

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) => setState(() => expanded = true)).then((value) => const Duration(seconds: 2)).then((value) => Future.delayed(const Duration(seconds: 2)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(color: AppColors.primary),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            8.heightBox,
            AnimatedDefaultTextStyle(
              duration: transitionDuration,
              curve: Curves.fastOutSlowIn,
              style: const TextStyle(color: AppColors.white),
              child: Image.asset(AppImages.imgLogo, width: context.width * 0.4,fit: BoxFit.contain,),
            ),
            8.heightBox,
            AnimatedCrossFade(
              secondCurve: Curves.bounceInOut,
              firstCurve: Curves.fastOutSlowIn,
              crossFadeState: !expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: transitionDuration,
              firstChild: Container(),
              secondChild: Padding(padding: const EdgeInsets.all(8.0), child: Text('Ash Meals',style: Theme.of(context).textTheme.displayMedium!.regular.copyWith(color: AppColors.white,fontSize: 32.sp))),
              alignment: Alignment.bottomCenter,
              sizeCurve: Curves.easeInOut,
            ),
            8.heightBox,
          ],
        ),
      ),
    );
  }
}
