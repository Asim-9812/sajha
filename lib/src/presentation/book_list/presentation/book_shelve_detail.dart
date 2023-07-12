
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sajha_prakasan/src/core/api.dart';

import 'package:sajha_prakasan/src/presentation/book_list/domain/model/book_list_model.dart';
import 'package:sajha_prakasan/src/presentation/book_list/presentation/book_rating_provider.dart';
import 'package:sajha_prakasan/src/presentation/common/cart_badge.dart';
import 'package:sajha_prakasan/src/presentation/common/date_formatter.dart';
import 'package:sajha_prakasan/src/presentation/common/snackbar.dart';
import 'package:sajha_prakasan/src/presentation/detail/presentation/provider/single_book_provider.dart';
import 'package:sajha_prakasan/src/presentation/detail/presentation/provider/user_comment_provider.dart';
import 'package:sajha_prakasan/src/presentation/login/domain/model/user.dart';
import 'package:sajha_prakasan/src/presentation/read_book/domain/service/pdf_api.dart';
import 'package:sajha_prakasan/src/presentation/read_book/domain/service/pdf_service.dart';


import 'package:sajha_prakasan/src/presentation/read_book/presentation/pdf_view.dart';

import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';

class MyBookDetailPage extends ConsumerStatefulWidget {
  final BookListModel purchasedBook;
  const MyBookDetailPage({Key? key, required this.purchasedBook}) : super(key: key);

  @override
  ConsumerState<MyBookDetailPage> createState() => _MyBookDetailPageState();
}

class _MyBookDetailPageState extends ConsumerState<MyBookDetailPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final commentController = TextEditingController();
  final userBox = Hive.box<User>('session').values.toList();

  int userRating = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final bookData = ref.watch(singleBookProvider(widget.purchasedBook.bookID!));

    final box = Hive.box<String>('tokenBox');
    final accessToken = box.get('accessToken');
    Icon starIcon =  Icon(Icons.star, color: ColorManager.yellowFellow, size: 20.h,);
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
        title: const Text('My Book Detail'),
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
                                      'Pages',
                                      style: getMediumStyle(
                                          color: ColorManager.blue,
                                          fontSize: 18.sp),
                                    ),
                                    Text(
                                      widget.purchasedBook.pages!,
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
                        height: 500,
                        child:
                        TabBarView(controller: _tabController, children: [
                          Text(
                            data.bookInfo!,
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'EDITION',
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
                                            widget.purchasedBook.publishedYearBS
                                                .toString(),
                                            style: getRegularStyle(
                                                color: Colors.black54,
                                                fontSize: 16.sp),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            widget.purchasedBook.isbn.toString(),
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
                                          Theme(
                                            data: ThemeData(
                                                chipTheme: ChipThemeData(
                                                  backgroundColor: const Color(0xff5FDEF4).withOpacity(0.5),
                                                  labelStyle: TextStyle(color: const Color(0xff258396), fontSize: 14.sp),
                                                  selectedColor: ColorManager.primary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5.r), // Decrease the border radius here
                                                  ),
                                                )
                                            ),
                                            child: Wrap(
                                              spacing: 15.0,
                                              children: [
                                                Chip(label: Text(widget.purchasedBook.edition!))
                                              ],
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
                                    Padding(
                                      padding: EdgeInsets.only(top: 5.h),
                                      child: IconButton(
                                          onPressed: (){
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                Color myColor = ColorManager.yellowFellow;
                                                final closeDialog = Navigator.of(context);
                                                return AlertDialog(
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                                  contentPadding: const EdgeInsets.only(top: 10.0),
                                                  content: SizedBox(
                                                    width: 300.0,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Text(
                                                                "Rate",
                                                                style: getMediumStyle(color: Colors.black, fontSize: 18.sp),
                                                              ),
                                                              SizedBox(width: 20.w,),
                                                              RatingBar.builder(
                                                                initialRating: 0,
                                                                minRating: 0,
                                                                direction: Axis.horizontal,
                                                                allowHalfRating: false,
                                                                itemCount: 5,
                                                                tapOnlyMode: false,
                                                                itemSize: 34.h,
                                                                itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
                                                                itemBuilder: (context, _) => starIcon,
                                                                onRatingUpdate: (rating) async {
                                                                  setState(() {
                                                                    userRating = rating.toInt();
                                                                  });
                                                                  },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        const Divider(
                                                          color: Colors.grey,
                                                          thickness: 1.0,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                          child: TextField(
                                                            controller: commentController,
                                                            decoration: const InputDecoration(
                                                              hintText: "Add comments here",
                                                              border: InputBorder.none,
                                                            ),
                                                            maxLines: 8,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            final scaffoldMessage = ScaffoldMessenger.of(context);
                                                            if(userRating != 0 && commentController.text.isEmpty){
                                                              final response = await ref.read(bookRatingProvider).addRating(token: accessToken!, bookId: widget.purchasedBook.bookID!, userId: userBox[0].userID, rating: userRating);
                                                              closeDialog.pop();
                                                              if(response != 'success'){
                                                                scaffoldMessage.showSnackBar(
                                                                    SnackbarUtil.showFailureSnackbar(message: 'Already rated!!', duration: const Duration(milliseconds: 1200))
                                                                );
                                                              }else{
                                                                setState(() {
                                                                  userRating = 0;
                                                                });
                                                                ref.refresh(singleBookProvider(widget.purchasedBook.bookID!));
                                                                scaffoldMessage.showSnackBar(
                                                                    SnackbarUtil.showSuccessSnackbar(message: 'Rating submitted', duration: const Duration(milliseconds: 1200))
                                                                );
                                                              }
                                                            } else if(userRating == 0 && commentController.text.isNotEmpty){
                                                              final response = await ref.read(commentProvider).addComment(
                                                                  token: accessToken!,
                                                                  userId: userBox[0].userID,
                                                                  bookId: widget.purchasedBook.bookID!,
                                                                  comment: commentController.text.trim()
                                                              );
                                                              closeDialog.pop();
                                                              if(response != 'success'){
                                                                scaffoldMessage.showSnackBar(
                                                                    SnackbarUtil.showFailureSnackbar(message: response, duration: const Duration(milliseconds: 1200))
                                                                );
                                                              }else{
                                                                ref.refresh(singleBookProvider(widget.purchasedBook.bookID!));
                                                                scaffoldMessage.showSnackBar(
                                                                    SnackbarUtil.showSuccessSnackbar(message: 'Comment Added!', duration: const Duration(milliseconds: 1200))
                                                                );
                                                              }
                                                            }
                                                            else if(userRating != 0 && commentController.text.isNotEmpty){
                                                              final response = await ref.read(commentProvider).addComment(
                                                                  token: accessToken!,
                                                                  userId: userBox[0].userID,
                                                                  bookId: widget.purchasedBook.bookID!,
                                                                  comment: commentController.text.trim()
                                                              );
                                                              if(response != 'success'){
                                                                final response1 = await ref.read(bookRatingProvider).addRating(token: accessToken, bookId: widget.purchasedBook.bookID!, userId: userBox[0].userID, rating: userRating);
                                                                closeDialog.pop();
                                                                if(response1 != 'success'){
                                                                  scaffoldMessage.showSnackBar(
                                                                      SnackbarUtil.showFailureSnackbar(message: response1, duration: const Duration(milliseconds: 1200))
                                                                  );
                                                                }else{
                                                                  setState(() {
                                                                    userRating = 0;
                                                                  });
                                                                  ref.refresh(singleBookProvider(widget.purchasedBook.bookID!));
                                                                  scaffoldMessage.showSnackBar(
                                                                      SnackbarUtil.showSuccessSnackbar(message: 'Rating added', duration: const Duration(milliseconds: 1200))
                                                                  );
                                                                }
                                                              }else{
                                                                final response2 = await ref.read(bookRatingProvider).addRating(token: accessToken, bookId: widget.purchasedBook.bookID!, userId: userBox[0].userID, rating: userRating);
                                                                closeDialog.pop();
                                                                if(response2 != 'success'){
                                                                  ref.refresh(singleBookProvider(widget.purchasedBook.bookID!));
                                                                  scaffoldMessage.showSnackBar(
                                                                      SnackbarUtil.showSuccessSnackbar(message: 'Review Added', duration: const Duration(milliseconds: 1200))
                                                                  );
                                                                }else{
                                                                  ref.refresh(singleBookProvider(widget.purchasedBook.bookID!));
                                                                  scaffoldMessage.showSnackBar(
                                                                      SnackbarUtil.showSuccessSnackbar(message: 'Review Successful!', duration: const Duration(milliseconds: 1200))
                                                                  );
                                                                }
                                                              }
                                                            }else{
                                                              closeDialog.pop();
                                                            }
                                                            commentController.clear();
                                                            setState(() {
                                                              userRating = 0;
                                                            });
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                                                            decoration: BoxDecoration(
                                                              color: myColor,
                                                              borderRadius: const BorderRadius.only(
                                                                  bottomLeft: Radius.circular(32.0),
                                                                  bottomRight: Radius.circular(32.0)),
                                                            ),
                                                            child: Text(
                                                              "Submit",
                                                              style: getMediumStyle(color: Colors.white, fontSize: 18.sp),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(Icons.add_comment, size: 30.h, color: ColorManager.blue,)
                                      ),
                                    ),
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
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 10.0, vertical: 5.0),
                              //   child: OutlinedButton(
                              //     onPressed: () {},
                              //     style: OutlinedButton.styleFrom(
                              //         minimumSize: Size(double.infinity, 50.h),
                              //         padding: EdgeInsets.symmetric(
                              //             horizontal: 12.w, vertical: 15.h),
                              //         side: BorderSide(
                              //             color: Colors.black.withOpacity(0.5),
                              //             width: 1.0,
                              //             strokeAlign:
                              //                 BorderSide.strokeAlignInside),
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadius.circular(10.r),
                              //         )),
                              //     child: Text(
                              //       'Load more reviews',
                              //       style: getMediumStyle(
                              //           color: ColorManager.black,
                              //           fontSize: 18.sp,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                height: 90.h,
                              ),
                            ],
                          )
                        ]),
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
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    height: 70.h,
                    color: Colors.white,
                    child:  SizedBox(
                      height: 50.h,
                      child: ElevatedButton(
                          onPressed: () async {
                            final result = await PDFService.getBookPdf(widget.purchasedBook.bookEditionID!);
                            final file = await PDFApi.loadNetwork(result);
                            Get.to(() => PDFViewerPage(file: file), transition: Transition.rightToLeft);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.primary,
                            textStyle: getMediumStyle(
                                color: Colors.white, fontSize: 20.sp),
                          ),
                          child: const Text('Start Reading')),
                    )
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => Text('$error'),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      userName,
                      style: getSemiBoldStyle(
                          color: ColorManager.black, fontSize: 16.sp),
                    ),
                    SizedBox(
                      width: 160.w,
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
