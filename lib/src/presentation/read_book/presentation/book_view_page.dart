



/// This page is used to demonstrate real life book flip effect using bookFX package. note that
/// this package is incompatible to pdfs and only renders images.
/// The goal is to take the flip inspiration from here and integrate with pdf or at least try to

// import 'package:flutter/material.dart';
// import 'package:bookfx/bookfx.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sajha_prakasan/src/presentation/read_book/domain/pages.dart';
// import 'package:sajha_prakasan/src/presentation/resources/style_manager.dart';
//
// import '../../resources/color_manager.dart';
//
// class BookPageView extends StatefulWidget {
//   const BookPageView({Key? key}) : super(key: key);
//
//   @override
//   State<BookPageView> createState() => _BookPageViewState();
// }
//
// class _BookPageViewState extends State<BookPageView> {
//   EBookController eBookController = EBookController();
//   BookController bookController = BookController();
//   TextEditingController textController = TextEditingController();
//
//   int count = 1;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 80,
//           ),
//           SizedBox(
//             height: 750.h,
//             child: BookFx(
//                 size: Size(MediaQuery.of(context).size.width,
//                     MediaQuery.of(context).size.height),
//                 pageCount: bookPage.length,
//                 currentPage: (index) {
//                   count = bookPage[index].id;
//                   return Image.asset(
//                     bookPage[index].imgUrl,
//                     fit: BoxFit.fill,
//                     width: MediaQuery.of(context).size.width,
//                     height: double.infinity,
//                   );
//                 },
//                 nextPage: (index) {
//                   count = bookPage[index].id;
//                   return Image.asset(
//                     bookPage[index].imgUrl,
//                     fit: BoxFit.fill,
//                     width: MediaQuery.of(context).size.width,
//                     height: double.infinity,
//                   );
//                 },
//                 controller: bookController),
//           ),
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 OutlinedButton(
//                   onPressed: () {
//                     bookController.last();
//                     if (count != 1) {
//                       setState(() {
//                         count--;
//                       });
//                     }
//                   },
//                   style: OutlinedButton.styleFrom(
//                       // minimumSize: Size(153.w, 60.h),
//                       padding: const EdgeInsets.all(13),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.r))),
//                   child: Text(
//                     'Previous',
//                     style: getRegularStyle(
//                       color: ColorManager.black,
//                       fontSize: 16.sp,
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: const Text("Go to "),
//                             content: SizedBox(
//                                 height: 100,
//                                 child: Column(
//                                   children: [
//                                     TextField(
//                                       controller: textController,
//                                       textInputAction: TextInputAction.go,
//                                       keyboardType: TextInputType.number,
//                                     ),
//                                     TextButton(
//                                         onPressed: () {
//                                           int index =
//                                               int.parse(textController.text);
//                                           bookController.goTo(index);
//                                           Navigator.pop(context);
//                                         },
//                                         child: const Text("OK"))
//                                   ],
//                                 )),
//                           );
//                         });
//                   },
//                   style: ElevatedButton.styleFrom(
//                       minimumSize: Size(100.w, 60.h),
//                       backgroundColor:
//                           ColorManager.brightGreen.withOpacity(0.7),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.r))),
//                   child: Text(
//                     'Page ${count} / ${bookPage.length}',
//                     style: getMediumStyle(
//                         color: ColorManager.white, fontSize: 18.sp),
//                   ),
//                 ),
//                 OutlinedButton(
//                   onPressed: () {
//                     bookController.next();
//                     if (count < 5) {
//                       setState(() {
//                         count++;
//                       });
//                     }
//                   },
//                   style: OutlinedButton.styleFrom(
//                       // minimumSize: Size(153.w, 60.h),
//                       padding: const EdgeInsets.all(13),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.r),
//                           side: BorderSide(
//                             color: ColorManager.primary,
//                           ))),
//                   child: Text(
//                     'Next',
//                     style: getRegularStyle(
//                       color: ColorManager.black,
//                       fontSize: 16.sp,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
