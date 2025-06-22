import 'package:ash_cart/core/resources/app_assets.dart';
import 'package:ash_cart/core/resources/app_colors.dart';
import 'package:ash_cart/core/utils/alerts.dart';
import 'package:ash_cart/core/view/components/empty_component.dart';
import 'package:ash_cart/core/view/components/error_component.dart';
import 'package:ash_cart/core/view/widgets/custom_button.dart';
import 'package:ash_cart/core/view/widgets/loading_spinner.dart';
import 'package:ash_cart/features/cart/domain/parameter/order_cart_parameters.dart';
import 'package:ash_cart/features/cart/presentation/cubit/clear_cart/clear_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/get_cart/get_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/cubit/order_cart/order_cart_cubit.dart';
import 'package:ash_cart/features/cart/presentation/widget/product_cart_item.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_json_view/flutter_json_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<GetCartCubit>().getCart();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 32.h,
                  height: 32.h,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.r),color: AppColors.white, boxShadow: [BoxShadow(color: AppColors.lightGrey, blurRadius: 2, spreadRadius: 2, offset: Offset(0, -1))],),
                  child: Center(child: Image.asset(AppImages.imgLogo).paddingAll(8)),
                ),
                SizedBox(width: context.width * 0.35,child: Text('Cart',textAlign: TextAlign.center,maxLines: 2,style: Theme.of(context).textTheme.headlineSmall?.medium.copyWith(color: AppColors.black))),
                Container(
                  width: 32.h,
                  height: 32.h,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.r),color: AppColors.white, boxShadow: [BoxShadow(color: AppColors.lightGrey, blurRadius: 2, spreadRadius: 2, offset: Offset(0, -1))],),
                  child: Center(child: Icon(Icons.menu,size: 24.sp,),),
                ),
              ],
            ).paddingSymmetric(vertical: 8.h,horizontal: 12.w),

            Expanded(
              child: BlocBuilder<GetCartCubit,GetCartState>(
            builder: (context, state) {
             if (state is GetCartLoading) {
                return LoadingSpinner();
              } else if (state is GetCartError) {
                return ErrorComponent(message: state.message, onRetry: ()=> context.read<GetCartCubit>().getCart());

              } else if (state is GetCartLoaded) {
                return state.localData.isEmpty 
                  ? EmptyComponent(title: 'Cart Is Empty',)
                  :
                   ListView.builder(  
                    itemCount: state.localData.length,
                    itemBuilder: (context, index) => ProductCartItem(model: state.localData[index],),
                  );
                
              }
              return ErrorComponent(message: 'Cart Is Empty', onRetry: ()=> context.read<GetCartCubit>().getCart());
            },
          ),
            ),

              SizedBox(
                child: BlocBuilder<GetCartCubit,GetCartState>(
                  builder: (context, state) {
                    
                    return state is GetCartLoaded && state.localData.isNotEmpty ? Column(
                      children: [
                        
                        BlocConsumer<OrderCartCubit,OrderCartState>(
                          builder: (context, orderState) => orderState is OrderCartLoading 
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  LoadingSpinner(),
                                  8.widthBox,
                                  Text("${orderState.progress} %",style: GoogleFonts.inter(fontSize: 14.sp,color: AppColors.primary,fontWeight: FontWeight.w700),),
                                ],
                              )
                            : CustomButton(
                                borderRadius: 12.r,
                                color: AppColors.primary,
                                height: 42.h,
                                onPressed: () {
                                  OrderCartParameters params = OrderCartParameters(dataList: state.localData);  
                                 context.read<OrderCartCubit>().orderCart(params); 
                                },
                                width: double.maxFinite,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Checkout', style: GoogleFonts.inter(color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                                    Text(
                                      '${state.totalPrice} EGP',
                                      style: GoogleFonts.inter(color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: 8.w),
                              ).paddingSymmetric(horizontal: 12.w,vertical: 8.h), 
                          listener: (context, orderState) {
                            if(orderState is OrderCartError) Alerts.showToast(orderState.message);
                            if(orderState is OrderCartLoaded){
                              Alerts.showToast('Order Success');
                              Alerts.showBottomSheet(context, child: SingleChildScrollView(child: JsonView.map(orderState.jsonResponse)), expandable: false,);
                              context.read<ClearCartCubit>().clearCart();
                              context.read<GetCartCubit>().getCart();
                            }
                          },
                        ),
                        
                        BlocConsumer<ClearCartCubit,ClearCartState>(
                          builder: (context, cartState) {
                            return cartState is ClearCartLoading 
                            ? LoadingSpinner()
                            : CustomButton(
                              borderRadius: 12.r,
                              color: AppColors.secandry,
                              height: 42.h,
                              onPressed: () => context.read<ClearCartCubit>().clearCart(),
                              width: double.maxFinite,
                              text: 'Delete All',
                              textColor: AppColors.white,
                              fontSize: 16.sp,
                            );
                          }, 
                          listener: (context, cartState) {
                            if(cartState is ClearCartError){
                              Alerts.showToast(cartState.message);
                            }
                            if(cartState is ClearCartLoading){
                              context.read<GetCartCubit>().getCart();
                              Alerts.showSnackBar(context, 'Your Cart Is Empty Now');
                            }
                          },
                        ).paddingSymmetric(horizontal: 12.w,vertical: 8.h),

                      ],
                    ): SizedBox();
                  },
                ),
              ),


            

          ],
      ),
      ),
    );
  }
}