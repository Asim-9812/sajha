import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/presentation/cart/data/provider/cart_provider.dart';

import 'package:sajha_prakasan/src/presentation/common/cart_badge.dart';
import 'package:sajha_prakasan/src/presentation/common/date_formatter.dart';
import 'package:sajha_prakasan/src/presentation/common/snackbar.dart';

import 'package:sajha_prakasan/src/presentation/detail/data/check_book.dart';
import 'package:sajha_prakasan/src/presentation/detail/presentation/provider/single_book_provider.dart';
import 'package:sajha_prakasan/src/presentation/login/domain/model/user.dart';


import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';


class BookDetailPage extends ConsumerStatefulWidget {
  final int bookId;

  const BookDetailPage({Key? key, required this.bookId}) : super(key: key);

  @override
  ConsumerState<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends ConsumerState<BookDetailPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  int _selectedIndex = 0;

  final userBox = Hive.box<User>('session').values.toList();

  final commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final bookData = ref.watch(singleBookProvider(widget.bookId));
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 5.0,
        shadowColor: ColorManager.blackOpacity15,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
              size: 28,
            )),
        title: const Text('Book Detail'),
        titleTextStyle:
            getSemiBoldStyle(color: ColorManager.black, fontSize: 20),
        actions: const [CartBadge()],
      ),
      body: bookData.when(
        data: (data) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: Image.network(
                          '${data.imagePath}',
                          height: 250.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        '${data.bookNameNepali}',
                        style: getSemiBoldStyle(
                            color: Colors.black, fontSize: 22.sp),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Colors.black.withOpacity(0.15),
                              width: 1),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Released',
                                      style: getMediumStyle(
                                          color: ColorManager.blue,
                                          fontSize: 18.sp),
                                    ),
                                    Text(
                                      'B.S. ${data.editions![0].publishedYearBS}',
                                      style: getMediumStyle(
                                          color: ColorManager.textGrey, fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Review',
                                      style: getMediumStyle(
                                          color: ColorManager.blue,
                                          fontSize: 18.sp),
                                    ),
                                    Text(
                                      '${data.commentCount}',
                                      style: getMediumStyle(
                                          color: Colors.black, fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Rating',
                                      style: getMediumStyle(
                                          color: ColorManager.blue,
                                          fontSize: 18.sp),
                                    ),
                                    Text(
                                      '⭐ ${data.avgRating == null ? 0 : (data.avgRating!).toStringAsFixed(1)}',
                                      style: getMediumStyle(
                                          color: Colors.black, fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 50,
                          ),
                          Positioned(
                            bottom: 2,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 1.8,
                              color: ColorManager.blueGray.withOpacity(0.2),
                            ),
                          ),
                          TabBar(
                              controller: _tabController,
                              labelColor: ColorManager.black,
                              unselectedLabelColor:
                                  ColorManager.textGrey.withOpacity(0.5),
                              isScrollable: true,
                              indicatorWeight: 1.0,
                              indicatorColor: Colors.black,
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 18.w),
                              labelStyle: TextStyle(
                                  fontSize: 18.sp, color: Colors.black),
                              tabs: const [
                                Tab(
                                  child: Text('Synopsis'),
                                ),
                                Tab(
                                  child: Text('Details'),
                                ),
                                Tab(
                                  child: Text('Author'),
                                ),
                                Tab(
                                  child: Text('Review'),
                                ),
                              ]),
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      SizedBox(
                        height: 500.h,
                        child:
                            TabBarView(controller: _tabController, children: [
                          Text(
                            '${data.bookInfo}',
                            style: getRegularStyle(
                                color: ColorManager.black, fontSize: 16.sp),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    width: 160.w,
                                    height: 400.h,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'PUBLISHER',
                                          style: getRegularStyle(
                                              color: Colors.black87,
                                              fontSize: 16.sp),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'FIRST PUBLISH',
                                          style: getRegularStyle(
                                              color: Colors.black87,
                                              fontSize: 16.sp),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'ISBN',
                                          style: getRegularStyle(
                                              color: Colors.black87,
                                              fontSize: 16.sp),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'LANGUAGE',
                                          style: getRegularStyle(
                                              color: Colors.black87,
                                              fontSize: 16.sp),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'TOTAL EDITION',
                                          style: getRegularStyle(
                                              color: Colors.black87,
                                              fontSize: 16.sp),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'GENRE',
                                          style: getRegularStyle(
                                              color: Colors.black87,
                                              fontSize: 16.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      height: 400.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.publisherName.toString(),
                                            style: getRegularStyle(
                                                color: Colors.black54,
                                                fontSize: 16.sp),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            data.editions![0].publishedYearBS
                                                .toString(),
                                            style: getRegularStyle(
                                                color: Colors.black54,
                                                fontSize: 16.sp),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            data.editions![0].isbn.toString(),
                                            style: getRegularStyle(
                                                color: Colors.black54,
                                                fontSize: 16.sp),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            data.language.toString(),
                                            style: getRegularStyle(
                                                color: Colors.black54,
                                                fontSize: 16.sp),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            data.editions!.length.toString(),
                                            style: getRegularStyle(
                                                color: Colors.black54,
                                                fontSize: 16.sp),
                                          ),
                                          Theme(
                                            data: ThemeData(
                                                chipTheme: ChipThemeData(
                                                  backgroundColor: const Color(0xff5FDEF4).withOpacity(0.5),
                                                  labelStyle: TextStyle(color: const Color(0xff258396), fontSize: 14.sp),
                                                  padding: EdgeInsets.zero,
                                                  selectedColor: ColorManager.primary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5.r), // Decrease the border radius here
                                                  ),
                                                )
                                            ),
                                            child: Wrap(
                                              spacing: 15.0,
                                              children: data.genreList!.map((e){
                                                return Chip(
                                                  label: Text(e.genreNepali),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          ListView.builder(
                            itemCount: data.authors!.length,
                            itemBuilder: (context, index) {
                              return data.authors![index].shortBio != "" ? ExpansionTile(
                                title: Text(
                                  '${data.authors![index].authorNameNepali}',
                                  style: getSemiBoldStyle(
                                      color: Colors.black, fontSize: 16.sp),
                                ),
                                subtitle: Text(
                                    '${data.authors![index].roleNepali}',
                                    style: getMediumStyle(
                                        color: ColorManager.textGrey,
                                        fontSize: 14.sp)),
                                childrenPadding:
                                EdgeInsets.symmetric(horizontal: 20.w),
                                expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.w),
                                    width: double.infinity,
                                    color: ColorManager.dotGrey.withOpacity(0.25),
                                    child: Text(
                                        data.authors![index].shortBio!.toString(),
                                        style: getRegularStyle(
                                            color: ColorManager.textGrey,
                                            fontSize: 14.sp)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ) : ListTile(
                                title: Text(
                                  '${data.authors![index].authorNameNepali}',
                                  style: getSemiBoldStyle(
                                      color: Colors.black, fontSize: 16.sp),
                                ),
                                subtitle: Text(
                                    '${data.authors![index].roleNepali}',
                                    style: getMediumStyle(
                                        color: ColorManager.textGrey,
                                        fontSize: 14.sp)),
                              );
                            },
                          ),
                          Column(
                            children: [
                             Container(
                               height: 60.h,
                               width: double.infinity,
                               decoration: BoxDecoration(
                                 border: Border(
                                   bottom: BorderSide(
                                     color: ColorManager.textGrey,
                                     width: 1.0, // Set the width of the border
                                   ),
                                 ),
                               ),
                               child:  Row(
                                 mainAxisAlignment:
                                 MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(
                                     'Reviews (${data.commentCount})',
                                     style: getBoldStyle(
                                         color: Colors.black, fontSize: 18.sp),
                                   ),
                                   Row(
                                     children: [
                                       Icon(Icons.star, color: ColorManager.yellowFellow, size: 28,),
                                       SizedBox(width: 5.w,),
                                       Text('${data.rateCount!}', style: getMediumStyle(color: Colors.black, fontSize: 18.sp),),
                                       SizedBox(width: 5.w,),
                                     ],
                                   )
                                 ],
                               ),
                             ),
                              SizedBox(height: 22.h),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: data.commentList!.length,
                                  itemBuilder: (context, index) {
                                    final commenter = data.commentList![index];
                                    return buildSizedBox(
                                      userName: '${commenter.fName}',
                                      rating: commenter.rating,
                                      imgUrI: commenter.profilePicUrl,
                                      time: commenter.createdDateTime,
                                      commentMsg: commenter.comments,
                                    );
                                  },
                                  separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                                ),
                              ),
                              SizedBox(
                                height: 100.h,
                              ),
                            ],
                          )
                        ]),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding:
                      EdgeInsets.only(right: 30.w, left: 30.w,),
                  height: 100.h,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return SizedBox(
                                        height: 400.h,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w, vertical: 20.h),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Select Book Edition',
                                                      style: getSemiBoldStyle(
                                                          color: ColorManager
                                                              .black,
                                                          fontSize: 18.sp)),
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: Icon(
                                                      Icons.close_rounded,
                                                      size: 22,
                                                      color:
                                                          ColorManager.iconGrey,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                  itemCount:
                                                      data.editions!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(16.r),
                                                          ),
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Book Edition ${data.editions![index].edition}',
                                                            style: getSemiBoldStyle(
                                                                color: ColorManager
                                                                    .blackOpacity80,
                                                                fontSize:
                                                                    16.sp),
                                                          ),
                                                          Text(
                                                            'Rs. ${data.editions![index].price}',
                                                            style: getBoldStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize:
                                                                    16.sp),
                                                          ),
                                                        ],
                                                      ),
                                                      subtitle: Text(
                                                        'Published : ${data.editions![index].publishedYearAD}',
                                                        style: getMediumStyle(
                                                            fontSize: 14.sp,
                                                            color: ColorManager.blackOpacity70,
                                                        ),
                                                      ),
                                                      tileColor:
                                                          _selectedIndex ==
                                                                  index
                                                              ? ColorManager
                                                                  .tileGreen
                                                              : null,
                                                      onTap: () {
                                                        setState(() {
                                                          _selectedIndex =
                                                              index;
                                                        });
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                  final scaffoldMessage = ScaffoldMessenger.of(context);
                                                  final result = await CheckBook().checkBook(userId: userBox[0].userID, bookEditionId: data.editions![_selectedIndex].bookEditionID!);
                                                  if(result.data["success"] == true){
                                                    final response = await ref.read(cartProvider.notifier).addToCart(data, data.editions![_selectedIndex],);
                                                    if(response == 'success'){
                                                      scaffoldMessage.showSnackBar(
                                                          SnackbarUtil.showSuccessSnackbar(
                                                              message: 'Successfully added to cart',
                                                              duration: const Duration(milliseconds: 1400)
                                                          ),
                                                      );
                                                    }else{
                                                      scaffoldMessage.showSnackBar(
                                                          SnackbarUtil.showFailureSnackbar(
                                                              message: 'Already added to cart',
                                                              duration: const Duration(milliseconds: 1400)
                                                          ),
                                                      );
                                                    }
                                                  }else{
                                                    scaffoldMessage.showSnackBar(
                                                        SnackbarUtil.showFailureSnackbar(
                                                            message: 'Book Already Purchased',
                                                            duration: const Duration(milliseconds: 1400)
                                                        ),
                                                    );
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      ColorManager.primary,
                                                  minimumSize: Size(
                                                      double.infinity, 50.h),
                                                ),
                                                child: Text(
                                                  'Continue',
                                                  style: getMediumStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.red,
                              padding: const EdgeInsets.all(8),
                              textStyle: getMediumStyle(
                                  color: Colors.white, fontSize: 20.sp),
                            ),
                            child: Text('Add to Cart',
                                style: getMediumStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 20.w,
                      // ),
                      // Expanded(
                      //   child: SizedBox(
                      //     height: 50.h,
                      //     child: ElevatedButton(
                      //         onPressed: () {
                      //           Get.to(const BookPageView(),
                      //               transition: Transition.rightToLeft);
                      //         },
                      //         style: ElevatedButton.styleFrom(
                      //             backgroundColor: ColorManager.primary,
                      //             textStyle: getMediumStyle(
                      //                 color: Colors.white, fontSize: 20.sp)),
                      //         child: const Text('Subscribe')),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => Center(child: Text('$error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  SizedBox buildSizedBox(
      {required String userName, String? imgUrI, int? rating, String? time, String? commentMsg}) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 64.h,
            width: 64.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: imgUrI != "" ? ClipOval(child: Image.network('${Api.baseUrl}$imgUrI', fit: BoxFit.fill, height: 64.h, width: 64.h,)) : CircleAvatar(radius: 40.r, backgroundColor: ColorManager.primary, child: Center(child: Text(userName[0])),),
          ),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userName,
                      style: getSemiBoldStyle(
                          color: ColorManager.black, fontSize: 16.sp),
                    ),
                    time != null ? Text(
                      '${formatDistanceToNowStrict(time)} ago',
                      style: getRegularStyle(
                          color: ColorManager.textGrey, fontSize: 14.sp),
                    ): const Text(''),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                children: [
                  Row(
                    children: List.generate(rating!, (index) => const Icon(Icons.star, color: Color(0xffffc700),)),
                  ),
                  Row(
                    children: List.generate(5 - rating, (index) => const Icon(Icons.star_border, color: Color(0xffffc700),)),
                  ),
                ],
              ),
                SizedBox(
                  height: 10.h,
                ),
                commentMsg != null ? Text(commentMsg, style: getMediumStyle(color: ColorManager.textGrey, fontSize: 14.sp),) : const Text(''),
              ],
            ),
          )
        ],
      ),
    );
  }
}





