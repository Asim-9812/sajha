// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:sajha_prakasan/src/presentation/resources/style_manager.dart';
//
// import '../../read_book/presentation/book_view_page.dart';
// import '../../resources/color_manager.dart';
// import '../../../domain/models/books.dart';
//
// class MyBooksView extends StatelessWidget {
//   const MyBooksView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: ColorManager.white,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(64.h),
//           child: Container(
//             height: 64.h,
//             width: double.infinity,
//             decoration: BoxDecoration(color: ColorManager.white, boxShadow: [
//               BoxShadow(
//                 color: ColorManager.black.withOpacity(0.05),
//                 offset: const Offset(0.0, 4.0),
//                 blurRadius: 20.0,
//               )
//             ]),
//             child: Center(
//               child: Text(
//                 'My Books',
//                 style: getSemiBoldStyle(
//                     color: ColorManager.black, fontSize: 24.sp),
//               ),
//             ),
//           ),
//         ),
//         body: SizedBox(
//           child: Column(
//             children: [
//               //const CustomAppBar(titleText: 'My Books', hasBoxShadow: true,),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Expanded(
//                 child: ListView.separated(
//                   shrinkWrap: true,
//                   itemCount: allBooks.length,
//                   itemBuilder: (context, index) {
//                     final bookData = allBooks[index];
//                     return Padding(
//                       padding: EdgeInsets.only(left: 14.w),
//                       child: Stack(
//                         children: [
//                           SizedBox(
//                             height: 210.h,
//                             width: 400.w,
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             child: Container(
//                               height: 160.h,
//                               width: 400.w,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color:
//                                           ColorManager.black.withOpacity(0.25),
//                                       offset: const Offset(2.0, 4.0),
//                                       blurRadius: 4.0,
//                                     )
//                                   ],
//                                   borderRadius: BorderRadius.circular(15)),
//                             ),
//                           ),
//                           Positioned(
//                             left: 12.w,
//                             right: 12.w,
//                             child: SizedBox(
//                               height: 200.h,
//                               width: 376.w,
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     height: 200.h,
//                                     width: 120.w,
//                                     decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(16.r),
//                                         image: DecorationImage(
//                                             image:
//                                                 AssetImage(bookData.imageUrl),
//                                             fit: BoxFit.cover)),
//                                   ),
//                                   SizedBox(
//                                     width: 16.w,
//                                   ),
//                                   Container(
//                                     margin: EdgeInsets.only(top: 48.h),
//                                     height: 160.h,
//                                     width: 240.w,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           bookData.title,
//                                           style: getSemiBoldStyle(
//                                               color: ColorManager.black,
//                                               fontSize: 24.sp),
//                                         ),
//                                         SizedBox(
//                                           height: 4.h,
//                                         ),
//                                         Text(
//                                           bookData.overview!,
//                                           style: getSemiBoldStyle(
//                                               color: ColorManager.black
//                                                   .withOpacity(0.5),
//                                               fontSize: 12.sp),
//                                           maxLines: 3,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                         SizedBox(
//                                           height: 7.h,
//                                         ),
//                                         Text(
//                                           'By ${bookData.author}',
//                                           style: getRegularStyle(
//                                               color: ColorManager.black,
//                                               fontSize: 14.sp),
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(bookData.rating!),
//                                             Text(
//                                               '(200)',
//                                               style: getRegularStyle(
//                                                   color: ColorManager.black,
//                                                   fontSize: 12.sp),
//                                             ),
//                                             SizedBox(
//                                               width: 20.5.w,
//                                             ),
//                                             SizedBox(
//                                               height: 30,
//                                               child: TextButton(
//                                                 onPressed: () {
//                                                   Get.to(
//                                                       () => BookPageView(),
//                                                       transition: Transition
//                                                           .rightToLeft);
//                                                 },
//                                                 child: Text(
//                                                   'Read now',
//                                                   style: getRegularStyle(
//                                                       color: ColorManager.blue,
//                                                       fontSize: 14.sp),
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                   separatorBuilder: (context, index) => SizedBox(
//                     height: 20.h,
//                   ),
//                 ),
//               ),
//               // Stack(
//               //   children: [
//               //     Container(
//               //       height: 210.h,
//               //       width: 400.w,
//               //       // color: Colors.red,
//               //     ),
//               //     Positioned(
//               //       bottom: 0,
//               //       child: Container(
//               //         height: 160.h,
//               //         width: 400.w,
//               //         decoration: BoxDecoration(
//               //             color: Colors.white,
//               //             boxShadow: [
//               //               BoxShadow(
//               //                 color: ColorManager.black.withOpacity(0.25),
//               //                 offset: const Offset(2.0, 4.0),
//               //                 blurRadius: 4.0,
//               //               )
//               //             ],
//               //             borderRadius: BorderRadius.circular(15)),
//               //       ),
//               //     ),
//               //     Positioned(
//               //       left: 12.w,
//               //       right: 12.w,
//               //       child: SizedBox(
//               //         height: 200.h,
//               //         width: 376.w,
//               //         child: Row(
//               //           children: [
//               //             Container(
//               //               height: 200.h,
//               //               width: 120.w,
//               //               decoration: BoxDecoration(
//               //                   borderRadius: BorderRadius.circular(16.r),
//               //                   image: const DecorationImage(
//               //                       image: AssetImage(
//               //                           'assets/images/muna_madan.png'),
//               //                       fit: BoxFit.cover)),
//               //             ),
//               //             SizedBox(
//               //               width: 16.w,
//               //             ),
//               //             Container(
//               //               margin: EdgeInsets.only(top: 50.h),
//               //               height: 160.h,
//               //               width: 240.w,
//               //               child: Column(
//               //                 crossAxisAlignment: CrossAxisAlignment.start,
//               //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //                 children: [
//               //                   Text(
//               //                     'Muna Madan',
//               //                     style: getSemiBoldStyle(
//               //                         color: ColorManager.black,
//               //                         fontSize: 24.sp),
//               //                   ),
//               //                   SizedBox(
//               //                     height: 4.h,
//               //                   ),
//               //                   Text(
//               //                     'At the heart of the poem is the relationship between Madan and Muna, hence the title of the play. While ostensibly a love poe.....',
//               //                     style: getSemiBoldStyle(
//               //                         color:
//               //                             ColorManager.black.withOpacity(0.5),
//               //                         fontSize: 12.sp),
//               //                   ),
//               //                   SizedBox(
//               //                     height: 7.h,
//               //                   ),
//               //                   Text(
//               //                     'By Laxmi Prasad Devkota',
//               //                     style: getRegularStyle(
//               //                         color: ColorManager.black,
//               //                         fontSize: 14.sp),
//               //                   ),
//               //                   Row(
//               //                     mainAxisAlignment:
//               //                         MainAxisAlignment.spaceBetween,
//               //                     children: [
//               //                       Text('⭐⭐⭐⭐⭐'),
//               //                       Text(
//               //                         '(200)',
//               //                         style: getRegularStyle(
//               //                             color: ColorManager.black,
//               //                             fontSize: 12.sp),
//               //                       ),
//               //                       SizedBox(
//               //                         width: 20.5.w,
//               //                       ),
//               //                       SizedBox(
//               //                         height: 40,
//               //                         child: TextButton(
//               //                           onPressed: () {},
//               //                           child: Text(
//               //                             'Read more',
//               //                           ),
//               //                         ),
//               //                       )
//               //                     ],
//               //                   ),
//               //                 ],
//               //               ),
//               //             ),
//               //           ],
//               //         ),
//               //       ),
//               //     )
//               //   ],
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
