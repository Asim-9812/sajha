import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sajha_prakasan/src/presentation/cart/data/provider/cart_provider.dart';
import 'package:sajha_prakasan/src/presentation/cart/domain/model/cart.dart';
import 'package:sajha_prakasan/src/presentation/common/app_bar.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';


import '../../payment/presentation/new_payment_page.dart';

enum ActionType { delete }

class CartPage extends ConsumerStatefulWidget {
  const CartPage({Key? key,}) : super(key: key);

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {

  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final totalPrice = ref.watch(cartProvider.notifier).getTotal;
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(titleText: 'Cart Items', hasBoxShadow: true, hasArrow: true,),
                SizedBox(
                  height: 20.h,
                ),
                cartData.isEmpty ?

                Column(
                  children: [
                    Image.asset('assets/icons/empty-cart.png', height: 350.h, width: 350.w,),
                    Center(child: Text('Empty Cart!! add some Books', style: getMediumStyle(color: ColorManager.black, fontSize: 18.sp),),),
                  ],
                ) : Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Your Cart (${cartData.length})',
                              style: getMediumStyle(color: ColorManager.primary, fontSize: 18.sp)
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cartData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                                child: buildCartIem(context, id: cartData[index].bookEditionId, imgUrl: cartData[index].imageUrl, bookPrice: cartData[index].price, bookName: cartData[index].bookName, bookEdition: cartData[index].edition, cartItem: cartData[index]),
                              );
                            },
                          ),
                          SizedBox(height: 200.h,),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: ColorManager.blackOpacity15,
                          offset: const Offset(0.0, -1.0),
                          blurRadius: 8.0
                      )
                    ]
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total', style: getBoldStyle(color: ColorManager.black, fontSize: 20.sp),),
                          Text('Rs. $totalPrice', style: getBoldStyle(color: ColorManager.black, fontSize: 20.sp),),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SizedBox(
                        height: 55.h,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: cartData.isEmpty ? null : () {
                              Get.to(() => const NewPaymentPage(), transition: Transition.rightToLeft, curve: Curves.linear);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                              disabledBackgroundColor: ColorManager.primary.withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),),),
                            child: Text(
                              'Check Out',
                              style: getMediumStyle(
                                  color: ColorManager.white, fontSize: 18.sp),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  Stack buildCartIem(BuildContext context, {required String bookName, required num bookPrice, required String imgUrl, required String bookEdition, required int id, required Cart cartItem}) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 22.w),
          height: 140.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.blackOpacity15,
                  offset: const Offset(1.0, 1.0),
                  blurRadius: 1.0,
                ),
              ]
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.network(
                  imgUrl,
                  height: 112.h,
                  width: 82.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 18.w,
              ),
              Expanded(
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        bookName,
                        style: getSemiBoldStyle(color: ColorManager.black, fontSize: 18.sp),
                      ),
                      Text('Rs. $bookPrice', style: getMediumStyle(color: ColorManager.black, fontSize: 18.sp),),
                     const Spacer(),
                      Container(
                        height: 26.h,
                        width: 72.w,
                        decoration: BoxDecoration(
                          color: const Color(0xffeeeeee),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(child: Text('Edition $bookEdition', style: getMediumStyle(color: Colors.black.withOpacity(0.65), fontSize: 12.sp),)),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: Material(
            color: Colors.transparent,
            child: IconButton(
                onPressed: (){
                  Get.defaultDialog(
                      title: 'Hold On',
                      content:
                      const Text('Are you sure you want to remove this item?', textAlign: TextAlign.center),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            ref.read(cartProvider.notifier).removeItem(cartItem);
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'),
                        ),
                      ]
                  );
                },
                icon: Icon(Icons.close, size: 18, color: ColorManager.iconGrey,),
            ),
          ),
        ),
      ],
    );
  }
}
