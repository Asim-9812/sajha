import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sajha_prakasan/src/presentation/common/app_bar.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';




class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({Key? key}) : super(key: key);

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage>{

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(titleText: 'Payment History', hasBoxShadow: true, hasArrow: true,),
            Expanded(
              child: SizedBox(
                child: DefaultTabController(
                    length: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: ButtonsTabBar(
                            borderColor: ColorManager.primary,
                            borderWidth: 1,
                            decoration: const BoxDecoration(
                                color: Colors.transparent,
                            ),
                            unselectedBorderColor: ColorManager.borderGreen,
                            unselectedDecoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            labelSpacing: 6,
                            unselectedLabelStyle: getMediumStyle(color: ColorManager.black, fontSize: 16.sp),
                            labelStyle: getMediumStyle(color: ColorManager.primary, fontSize: 16.sp),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                            tabs: [
                              const Tab(
                                text: "7 Days",
                              ),
                              const Tab(
                                text: "1 month",
                              ),
                              const Tab(
                                text: "1 year",
                              ),
                              Tab(
                                text: "Filter",
                                icon: FaIcon(FontAwesomeIcons.filter, color: ColorManager.iconGrey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 22.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 35.h,),
                                    const CustomPaymentCard(
                                      imageUrl: 'assets/images/muna_madan.png',
                                      payDate: 'Fri, 18 Nov',
                                      bookName: 'Muna Madan',
                                      price: 'NPR. 400',
                                      fullDate: 'Fri, 18 Nov at 6:28 pm',
                                      status: 'success',
                                    ),
                                    SizedBox(height: 30.h,),
                                    const CustomPaymentCard(
                                      imageUrl: 'assets/images/muna_madan.png',
                                      payDate: 'Fri, 18 Nov',
                                      bookName: 'Muna Madan',
                                      price: 'NPR. 400',
                                      fullDate: 'Fri, 18 Nov at 6:28 pm',
                                      status: 'success',
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 22.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 35.h,),
                                    const CustomPaymentCard(
                                      imageUrl: 'assets/images/muna_madan.png',
                                      payDate: 'Fri, 18 Nov',
                                      bookName: 'Muna Madan',
                                      price: 'NPR. 400',
                                      fullDate: 'Fri, 18 Nov at 6:28 pm',
                                      status: 'success',
                                    ),
                                    SizedBox(height: 25.h,),
                                    const CustomPaymentCard(
                                      imageUrl: 'assets/images/ijoriya.png',
                                      payDate: 'Mon, 6 Nov',
                                      bookName: 'Ijoriya',
                                      price: 'NPR. 800',
                                      fullDate: 'Mon, 6 Nov at 1:47 pm',
                                      status: 'success',
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 22.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 35.h,),
                                    const CustomPaymentCard(
                                      imageUrl: 'assets/images/muna_madan.png',
                                      payDate: 'Fri, 18 Nov',
                                      bookName: 'Muna Madan',
                                      price: 'NPR. 400',
                                      fullDate: 'Fri, 18 Nov at 6:28 pm',
                                      status: 'success',
                                    ),
                                    SizedBox(height: 25.h,),
                                    const CustomPaymentCard(
                                      imageUrl: 'assets/images/ijoriya.png',
                                      payDate: 'Mon, 6 Nov',
                                      bookName: 'Ijoriya',
                                      price: 'NPR. 800',
                                      fullDate: 'Mon, 6 Nov at 1:47 pm',
                                      status: 'success',
                                    ),
                                    SizedBox(height: 25.h,),
                                    const CustomPaymentCard(
                                      imageUrl: 'assets/images/antarman.png',
                                      payDate: 'Mon, 6 April',
                                      bookName: 'Antarman ko Yatra',
                                      price: 'NPR. 400',
                                      fullDate: 'Mon, 6 April at 8:47 pm',
                                      status: 'success',
                                    ),
                                  ],
                                ),
                              ),
                              const Center(
                                child: Icon(Icons.directions_car),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                )
              ),
            )
          ],
        )
      ),
    );
  }
}

class CustomPaymentCard extends StatelessWidget {
  final String payDate;
  final String bookName;
  final String price;
  final String fullDate;
  final String status;
  final String imageUrl;
  const CustomPaymentCard({
    Key? key, required this.payDate, required this.bookName, required this.price, required this.fullDate, required this.status, required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(payDate, style: getBoldStyle(color: ColorManager.black, fontSize: 18.sp),),
        SizedBox(height: 10.h,),
        Container(
          height: 180.h,
          width: 380.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                    color: ColorManager.blackOpacity15,
                    offset: const Offset(
                      0.5,
                      1.0,
                    ),
                    blurRadius: 2.0
                )
              ]
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(imageUrl, height: 140.h, width: 90.w, fit: BoxFit.cover,),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  width: 230.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bookName, style: getMediumStyle(color: ColorManager.black, fontSize: 20.sp),),
                      const Spacer(),
                      Text(price, style: getRegularStyle(color: ColorManager.black, fontSize: 14.sp),),
                     const Spacer(),
                      Row(
                        children: [
                          Icon(Icons.history, size: 22, color: ColorManager.iconGrey,),
                          SizedBox(width: 6.w,),
                          Text(fullDate, style: getRegularStyle(color: ColorManager.blackOpacity70, fontSize: 12.sp),),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 24.h,
                            width: 76.w,
                            decoration: BoxDecoration(
                              color: ColorManager.successBadgeBg,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(child: Text('SUCCESS', style: getMediumStyle(color: ColorManager.successBadgeText, fontSize: 14.sp),)),
                          ),
                          SizedBox(
                            height: 24.h,
                            // width: 50.h,
                            child: IconButton(
                              onPressed: (){
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20.r),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: 300.h,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 35.w, vertical: 20.h),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'MORE OPTIONS',
                                                  style: getSemiBoldStyle(
                                                      color: ColorManager.black,
                                                      fontSize: 14.sp),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: Icon(
                                                    Icons.close_rounded,
                                                    size: 24.h,
                                                    color: ColorManager.iconGrey,
                                                  ),
                                                )
                                              ],
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.remove_red_eye_sharp,
                                                size: 24.h,
                                                color: ColorManager.iconGrey,
                                              ),
                                              title: Text(
                                                'View Details',
                                                style: getMediumStyle(
                                                    color: Colors.black, fontSize: 16.sp),
                                              ),
                                              minLeadingWidth: 10.w,
                                              tileColor: ColorManager.listTile,
                                              onTap: () {},
                                            ),
                                            const Divider(
                                              thickness: 1.5,
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.file_download_outlined,
                                                size: 24.h,
                                                color: ColorManager.iconGrey,
                                              ),
                                              title: Text(
                                                'Download PDF',
                                                style: getMediumStyle(
                                                    color: Colors.black, fontSize: 16.sp),
                                              ),
                                              minLeadingWidth: 10.w,
                                              tileColor: ColorManager.listTile,
                                              onTap: () {},
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.more_vert, color: ColorManager.iconGrey, size: 24.h,),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
