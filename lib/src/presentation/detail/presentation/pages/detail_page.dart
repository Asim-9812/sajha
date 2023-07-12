// import 'package:expandable_text/expandable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:sajha_prakasan/src/presentation/dashboard/domain/model/book_model.dart';
// import 'package:sajha_prakasan/src/presentation/cart/cart_page.dart';
// import 'package:sajha_prakasan/src/presentation/resources/style_manager.dart';
//
//
// import '../../domain/models/books.dart';
// import '../resources/color_manager.dart';
//
// enum SingingCharacter { selected, notSelected }
//
// class BookDetailView extends StatefulWidget {
//   final BookDetails book;
//
//   const BookDetailView({
//     Key? key,
//     required this.book,
//   }) : super(key: key);
//
//   @override
//   State<BookDetailView> createState() => _BookDetailViewState();
// }
//
// class _BookDetailViewState extends State<BookDetailView> {
//   SingingCharacter? _character = SingingCharacter.selected;
//
//
//   @override
//   void initState() {
//     super.initState();
//     cartItemList.length;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_new,
//           ),
//           iconSize: 30,
//           color: Colors.white,
//         ),
//         elevation: 0,
//         backgroundColor: ColorManager.primary.withOpacity(0.8),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: Stack(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Get.to(() => const CartPage());
//                   },
//                   icon: const Icon(
//                     Icons.shopping_cart_outlined,
//                     size: 30,
//                     color: Colors.white,
//                   ),
//                 ),
//                 Positioned(
//                   top: 2,
//                   right: 0,
//                   child:  cartItemList.isEmpty ? const Text('') : Container(
//                     height: 20,
//                     width: 20,
//                     decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: Center(child: Text(
//                       '${cartItemList.length}', style: getRegularStyle(color: Colors.white, fontSize: 14),)),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Stack(
//           children: [
//             Container(
//               height: 382.h,
//               width: double.infinity,
//               color: ColorManager.primary.withOpacity(0.8),
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   top: 30.h,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(left: 32.w),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             widget.book.bookNameNepali.toString(),
//                             style: getBoldStyle(
//                                 color: ColorManager.white, fontSize: 30.sp),
//                           ),
//                           Text(
//                            'by - ${widget.book.authors![0].authorNameEnglish}',
//                             style: getMediumStyle(
//                                 color: ColorManager.white, fontSize: 14.sp),
//                           ),
//                           SizedBox(height: 80.h,),
//                           Text(
//                             'Price',
//                             style: getMediumStyle(
//                                 color: ColorManager.white, fontSize: 24.sp),
//                           ),
//                           Text(
//                             'Rs. 499.0',
//                             style: getBoldStyle(
//                                 color: ColorManager.white, fontSize: 20.sp),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 250.h),
//               //height: 1320.h,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(30.r),
//                 ),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 32.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 80.h,
//                     ),
//                     // Text(
//                     //   'Subscribe now :',
//                     //   style: getSemiBoldStyle(
//                     //       color: ColorManager.black, fontSize: 20.sp),
//                     // ),
//                     // SizedBox(
//                     //   height: 33.h,
//                     // ),
//                     // Container(
//                     //   height: 70.h,
//                     //   width: 315.w,
//                     //   decoration: BoxDecoration(
//                     //     color: Colors.transparent,
//                     //     border: Border.all(
//                     //         color: ColorManager.primaryDark,
//                     //         width: 1.w,
//                     //         strokeAlign: BorderSide.strokeAlignInside),
//                     //     borderRadius: BorderRadius.circular(5.r),
//                     //   ),
//                     //   child: Row(
//                     //     children: [
//                     //       Theme(
//                     //         data: ThemeData(
//                     //             unselectedWidgetColor: ColorManager.primary),
//                     //         child: Transform.scale(
//                     //           scale: 1.2,
//                     //           child: Radio<SingingCharacter>(
//                     //             value: SingingCharacter.selected,
//                     //             groupValue: _character,
//                     //             onChanged: (value) {
//                     //               setState(() {
//                     //                 _character = value;
//                     //               });
//                     //             },
//                     //             toggleable: true,
//                     //             activeColor: ColorManager.primary,
//                     //           ),
//                     //         ),
//                     //       ),
//                     //       Padding(
//                     //         padding: EdgeInsets.symmetric(horizontal: 10.w),
//                     //         child: Column(
//                     //           crossAxisAlignment: CrossAxisAlignment.start,
//                     //           children: [
//                     //             Padding(
//                     //               padding: EdgeInsets.only(top: 8.w),
//                     //               child: Row(
//                     //                 mainAxisAlignment:
//                     //                     MainAxisAlignment.spaceBetween,
//                     //                 children: [
//                     //                   Text(
//                     //                     'Basic',
//                     //                     style: getBoldStyle(
//                     //                         color: ColorManager.primaryDark,
//                     //                         fontSize: 18.sp),
//                     //                   ),
//                     //                   SizedBox(
//                     //                     width: 94.w,
//                     //                   ),
//                     //                   Text(
//                     //                     'NPR.400/mo',
//                     //                     style: getSemiBoldStyle(
//                     //                         color: ColorManager.primaryDark,
//                     //                         fontSize: 16.sp),
//                     //                   )
//                     //                 ],
//                     //               ),
//                     //             ),
//                     //             SizedBox(
//                     //               height: 5.h,
//                     //             ),
//                     //             Text(
//                     //               'Get it  one month',
//                     //               style: getRegularStyle(
//                     //                   color: ColorManager.black,
//                     //                   fontSize: 12.sp),
//                     //             )
//                     //           ],
//                     //         ),
//                     //       )
//                     //     ],
//                     //   ),
//                     // ),
//                     // SizedBox(
//                     //   height: 13.h,
//                     // ),
//                     // Container(
//                     //   height: 70.h,
//                     //   width: 315.w,
//                     //   decoration: BoxDecoration(
//                     //     color: Colors.transparent,
//                     //     border: Border.all(
//                     //       color: ColorManager.primaryDark,
//                     //       width: 1.w,
//                     //       strokeAlign: BorderSide.strokeAlignInside,
//                     //     ),
//                     //     borderRadius: BorderRadius.circular(5.r),
//                     //   ),
//                     //   child: Row(
//                     //     children: [
//                     //       Theme(
//                     //         data: ThemeData(
//                     //             unselectedWidgetColor: ColorManager.primary),
//                     //         child: Transform.scale(
//                     //           scale: 1.2,
//                     //           child: Radio<SingingCharacter>(
//                     //             value: SingingCharacter.notSelected,
//                     //             groupValue: _character,
//                     //             onChanged: (value) {
//                     //               setState(() {
//                     //                 _character = value;
//                     //               });
//                     //             },
//                     //             toggleable: true,
//                     //             activeColor: ColorManager.primary,
//                     //           ),
//                     //         ),
//                     //       ),
//                     //       Padding(
//                     //         padding: EdgeInsets.symmetric(horizontal: 10.w),
//                     //         child: Column(
//                     //           crossAxisAlignment: CrossAxisAlignment.start,
//                     //           children: [
//                     //             Padding(
//                     //               padding: EdgeInsets.only(top: 8.w),
//                     //               child: Row(
//                     //                 mainAxisAlignment:
//                     //                     MainAxisAlignment.spaceBetween,
//                     //                 children: [
//                     //                   Text(
//                     //                     'Premium',
//                     //                     style: getBoldStyle(
//                     //                         color: ColorManager.primaryDark,
//                     //                         fontSize: 18.sp),
//                     //                   ),
//                     //                   SizedBox(
//                     //                     width: 64.w,
//                     //                   ),
//                     //                   Text(
//                     //                     'NPR.1000/mo',
//                     //                     style: getSemiBoldStyle(
//                     //                         color: ColorManager.primaryDark,
//                     //                         fontSize: 16.sp),
//                     //                   )
//                     //                 ],
//                     //               ),
//                     //             ),
//                     //             SizedBox(
//                     //               height: 5.h,
//                     //             ),
//                     //             Text(
//                     //               'Get it  one month',
//                     //               style: getRegularStyle(
//                     //                   color: ColorManager.black,
//                     //                   fontSize: 12.sp),
//                     //             )
//                     //           ],
//                     //         ),
//                     //       )
//                     //     ],
//                     //   ),
//                     // ),
//                     // SizedBox(
//                     //   height: 65.h,
//                     // ),
//
//                     Text(
//                       'Book Description',
//                       style:
//                           getMediumStyle(color: Colors.black, fontSize: 20.sp),
//                     ),
//                     SizedBox(
//                       height: 6.h,
//                     ),
//                     ExpandableText(
//                       '${widget.book.authors![0].authorNameEnglish.toString()} As the title tells this is a book about the adventure of inner self when the mystery of unknown is exposed.By reading the book you get to know that people not only fear about unknown but they are baffled in the same way when the great mystery of end no longer remains mystery .',
//                       style: getMediumStyle(
//                         color: ColorManager.textGrey,
//                         fontSize: 14.sp,
//                       ),
//                       expandText: 'Read more',
//                       collapseText: 'Read less',
//                       linkColor: ColorManager.primary,
//                       maxLines: 3,
//                     ),
//                     SizedBox(
//                       height: 52.h,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Reviews (26)',
//                           style: getBoldStyle(
//                               color: Colors.black, fontSize: 18.sp),
//                         ),
//                         Text(
//                           '⭐ 4.6',
//                           style: getMediumStyle(
//                               color: Colors.black, fontSize: 18.sp),
//                         )
//                       ],
//                     ),
//                     SizedBox(height: 22.h),
//                     buildSizedBox(
//                         userName: 'Aisha',
//                         imgUrI:
//                             'https://images.unsplash.com/photo-1626943789936-09fcc6cf58ff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fG11c2xpbSUyMHdvbWVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
//                         ago: '2 months ago',
//                     ),
//                     SizedBox(
//                       height: 20.h,
//                     ),
//                     buildSizedBox(
//                         userName: 'Bijaya',
//                         imgUrI:
//                             'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzR8fHBlcnNvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
//                         ago: '1 year ago'),
//                     SizedBox(
//                       height: 20.h,
//                     ),
//                     buildSizedBox(
//                         userName: 'Krisna',
//                         imgUrI:
//                             'https://images.unsplash.com/photo-1619380061814-58f03707f082?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8aW5kaWFuJTIwbWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
//                         ago: '3 years ago'),
//                     SizedBox(
//                       height: 43.h,
//                     ),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50.h,
//                       child: OutlinedButton(
//                         onPressed: () {},
//                         style: OutlinedButton.styleFrom(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 12.w, vertical: 15.h),
//                             shape: RoundedRectangleBorder(
//                               side: BorderSide(
//                                   color: ColorManager.black,
//                                   width: 1.0,
//                                   strokeAlign: BorderSide.strokeAlignInside),
//                               borderRadius: BorderRadius.circular(10.r),
//                             )),
//                         child: Text(
//                           'Load more reviews',
//                           style: getMediumStyle(
//                               color: ColorManager.black, fontSize: 16.sp),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 62.h,
//                     ),
//                     SizedBox(
//                       height: 50.h,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // setState(() {
//                           //   cartItemList.add(widget.book);
//                           // });
//                           // Get.to(
//                           //     () => CartPage(
//                           //           book: widget.book,
//                           //         ),
//                           //     transition: Transition.rightToLeft,
//                           //     curve: Curves.linear
//                           // );
//                         },
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: ColorManager.red,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.r))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Icon(
//                               Icons.shopping_cart_outlined,
//                               size: 30,
//                             ),
//                             SizedBox(
//                               width: 10.w,
//                             ),
//                             Text(
//                               'Add To Cart',
//                               style: getBoldStyle(
//                                   color: ColorManager.white, fontSize: 20.sp),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 50.h,),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 80.h,
//               left: 240.w,
//               right: 20.w,
//               child: Container(
//                 height: 250.h,
//                 width: 169.w,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: ColorManager.blackOpacity25,
//                       offset: const Offset(1.0, 1.0),
//                       blurRadius: 2,
//                       spreadRadius: 1.0,
//                     )
//                   ],
//                 ),
//                 child: Hero(
//                   tag: widget.book,
//                   transitionOnUserGestures: true,
//                   child: Image.asset(
//                     allBooks[0].imageUrl,
//                     height: 250.h,
//                     width: 169.w,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   SizedBox buildSizedBox(
//       {required String userName, required String imgUrI, required String ago}) {
//     return SizedBox(
//       height: 120.h,
//       width: double.infinity,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 64.h,
//             width: 64.h,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(50.r),
//               image: DecorationImage(
//                   image: Image.network(imgUrI).image, fit: BoxFit.cover),
//             ),
//           ),
//           SizedBox(
//             width: 15.w,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     userName,
//                     style: getSemiBoldStyle(
//                         color: ColorManager.black, fontSize: 16.sp),
//                   ),
//                   SizedBox(
//                     width: 160.w,
//                   ),
//                   Text(
//                     ago,
//                     style: getRegularStyle(
//                         color: ColorManager.textGrey, fontSize: 14.sp),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 5.h,
//               ),
//               Text('${allBooks[0].rating}'),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Text(
//                 'Lorem ipsum dolor sit amet, consectetur adipiscing el',
//                 style: getMediumStyle(
//                     color: ColorManager.textGrey, fontSize: 12.sp),
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Text(
//                 'sed do eiusmod tempor incididunt ut labo',
//                 style: getMediumStyle(
//                     color: ColorManager.textGrey, fontSize: 12.sp),
//                 overflow: TextOverflow.ellipsis,
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
