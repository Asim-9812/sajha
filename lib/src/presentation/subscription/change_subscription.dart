// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:sajha_prakasan/src/presentation/common/app_bar.dart';
// import 'package:sajha_prakasan/src/presentation/resources/style_manager.dart';
//
// import '../resources/color_manager.dart';
//
// class ChangeSubscriptionPage extends StatefulWidget {
//   const ChangeSubscriptionPage({Key? key}) : super(key: key);
//
//   @override
//   State<ChangeSubscriptionPage> createState() => _ChangeSubscriptionPageState();
// }
//
// class _ChangeSubscriptionPageState extends State<ChangeSubscriptionPage> {
//   late bool isBasic;
//   late bool isPremium;
//
//   final int basicPrice = 400;
//   final int premiumPrice = 1000;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     isBasic = false;
//     isPremium = true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const CustomAppBar(titleText: 'Edit Subscription', hasBoxShadow: true, hasArrow: true),
//             SizedBox(
//               height: 32.h,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Your Subscriptions',
//                     style: getSemiBoldStyle(
//                         color: ColorManager.black, fontSize: 20.sp),
//                   ),
//                   SizedBox(
//                     height: 9.h,
//                   ),
//                   Text(
//                     'Basic',
//                     style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w400,
//                         decoration: TextDecoration.underline),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   buildItemStack(context, imgUrl: 'assets/images/muna_madan.png', bookName: 'Muna Madan', authorName: 'Laxmi Prasad Devkota', timeLeft: '9 days left'),
//                   SizedBox(height: 30.h,),
//                   buildItemStack(context, imgUrl: 'assets/images/antarman.png', bookName: 'Antarman ko Yatra', authorName: 'Jagdish Ghimire', timeLeft: '22 days left'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Stack buildItemStack(BuildContext context, {required String imgUrl, required String bookName, required String authorName, required String timeLeft,}) {
//     return Stack(
//       children: [
//         Container(
//           height: 210.h,
//           width: 380.w,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15.r),
//               boxShadow: [
//                 BoxShadow(
//                     color: ColorManager.blackOpacity15,
//                     offset: const Offset(
//                       0.5,
//                       1.0,
//                     ),
//                     blurRadius: 1.0
//                 )
//               ],
//           ),
//         ),
//         Positioned(
//           right: 0,
//           child: Material(
//             color: Colors.transparent,
//             child: IconButton(
//               onPressed: () {
//                 showModalBottomSheet(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(20.r),
//                     ),
//                   ),
//                   context: context,
//                   builder: (context) {
//                     return SizedBox(
//                       height: 300.h,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 35.w, vertical: 20.h),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'MORE OPTIONS',
//                                   style: getSemiBoldStyle(
//                                       color: ColorManager.black,
//                                       fontSize: 14.sp),
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   icon: Icon(
//                                     Icons.close_rounded,
//                                     size: 24.h,
//                                     color: ColorManager.iconGrey,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             ListTile(
//                               leading: Icon(
//                                 Icons.remove_red_eye_sharp,
//                                 size: 24.h,
//                                 color: ColorManager.iconGrey,
//                               ),
//                               title: Text(
//                                 'View Details',
//                                 style: getMediumStyle(
//                                     color: Colors.black, fontSize: 16.sp),
//                               ),
//                               minLeadingWidth: 10.w,
//                               tileColor: ColorManager.listTile,
//                               onTap: () {},
//                             ),
//                             const Divider(
//                               thickness: 1.5,
//                             ),
//                             ListTile(
//                               leading: Icon(
//                                 Icons.file_download_outlined,
//                                 size: 24.h,
//                                 color: ColorManager.iconGrey,
//                               ),
//                               title: Text(
//                                 'Download PDF',
//                                 style: getMediumStyle(
//                                     color: Colors.black, fontSize: 16.sp),
//                               ),
//                               minLeadingWidth: 10.w,
//                               tileColor: ColorManager.listTile,
//                               onTap: () {},
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//               icon: Icon(
//                 Icons.more_vert_rounded,
//                 color: ColorManager.iconGrey,
//                 size: 24.h,
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Image.asset(
//                 imgUrl,
//                 height: 170.h,
//                 width: 120.w,
//               ),
//               SizedBox(
//                 width: 200.w,
//                 height: 170.h,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       bookName,
//                       style: getMediumStyle(
//                           color: ColorManager.black, fontSize: 20.sp),
//                     ),
//                     const Spacer(),
//                     Text(
//                       authorName,
//                       style: getRegularStyle(
//                           color: ColorManager.black, fontSize: 14.sp),
//                     ),
//                     const Spacer(),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.history,
//                           size: 22.h,
//                           color: ColorManager.iconGrey,
//                         ),
//                         SizedBox(
//                           width: 6.w,
//                         ),
//                         Text(
//                           timeLeft,
//                           style: getRegularStyle(
//                               color: ColorManager.red, fontSize: 12.sp),
//                         ),
//                       ],
//                     ),
//                    const Spacer(),
//                     Row(
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               isPremium = false;
//                               isBasic = true;
//                             });
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: isBasic
//                                 ? ColorManager.primary
//                                 : ColorManager.inputGreen,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.r),
//                             ),
//                             minimumSize: Size(72.w, 40.h),
//                             elevation: 1,
//                           ),
//                           child: Text(
//                             'Basic',
//                             style: getMediumStyle(
//                                 color: isBasic
//                                     ? ColorManager.white
//                                     : ColorManager.black,
//                                 fontSize: 12.sp),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 8.w,
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               isBasic = false;
//                               isPremium = true;
//                             });
//                             showDialog(
//                                 context: context,
//                                 builder: (context) => AlertDialog(
//                                   content: Container(
//                                     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
//                                     height: 180.h,
//                                     width: 325.w,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Text('Add Rs. 200 to upgrade', style: getBoldStyle(color: Colors.black, fontSize: 20.sp),),
//                                         SizedBox(height: 10.h,),
//                                         Text('once you upgrade to premium you cannot return back to basic', style: getRegularStyle(color: ColorManager.textGrey, fontSize: 16.sp), textAlign: TextAlign.center),
//                                         SizedBox(height: 20.h,),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             TextButton(
//                                                 onPressed: (){},
//                                                 child: Text('Yes'),
//                                             ),
//                                             TextButton(
//                                               onPressed: (){},
//                                               child: Text('No'),
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: isPremium
//                                 ? ColorManager.primary
//                                 : ColorManager.inputGreen,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.r),
//                             ),
//                             minimumSize: Size(100.w, 40.h),
//                             elevation: 1,
//                           ),
//                           child: Text(
//                             'Premium',
//                             style: getMediumStyle(
//                                 color: isPremium
//                                     ? ColorManager.white
//                                     : ColorManager.black,
//                                 fontSize: 12.sp),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Spacer(),
//                     RichText(
//                       text: TextSpan(children: <TextSpan>[
//                         TextSpan(
//                             text: 'Price:  ',
//                             style: getRegularStyle(
//                                 color: ColorManager.black, fontSize: 16.sp)),
//                         TextSpan(
//                             text: 'Rs. ${isBasic ? basicPrice : premiumPrice}',
//                             style: getRegularStyle(
//                                 color: ColorManager.red, fontSize: 16.sp)),
//                       ]),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
