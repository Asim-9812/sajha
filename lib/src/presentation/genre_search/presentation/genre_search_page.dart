import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sajha_prakasan/src/core/utils/shimmer.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/domain/model/book_model.dart';
import 'package:sajha_prakasan/src/presentation/detail/presentation/pages/new_detail_page.dart';
import 'package:sajha_prakasan/src/presentation/genre_search/data/provider/genre_search_provider.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';

class GenreSearchPage extends ConsumerStatefulWidget {

  const GenreSearchPage({Key? key,}) : super(key: key);

  @override
  ConsumerState<GenreSearchPage> createState() => _GenreSearchPageState();
}

class _GenreSearchPageState extends ConsumerState<GenreSearchPage> {
  final controller = TextEditingController();

  String genre = "history";

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookDataList = ref.watch(genreSearchProvider(genre));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30.h,
              color: ColorManager.black,
            )),
        title: const Text('All Categories'),
        titleTextStyle: getSemiBoldStyle(
          color: ColorManager.black,
          fontSize: 22.sp,
        ),
        elevation: 2.0,
        shadowColor: ColorManager.blackOpacity15,
        scrolledUnderElevation: 5.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorManager.inputGreen,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(
                      color: ColorManager.primary,
                    ),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 21.w),
                  suffixIcon: controller.text.isNotEmpty
                      ? GestureDetector(
                    child:
                    Icon(Icons.close, color: ColorManager.iconGrey),
                    onTap: () {
                      controller.clear();
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                      : Icon(
                    CupertinoIcons.search,
                    color: ColorManager.iconGrey,
                  ),
                  hintText: 'Search by book Genre',
                  hintStyle: getMediumStyle(
                      color: ColorManager.textGrey, fontSize: 16.sp),
                ),
                cursorColor: ColorManager.brightGreen,
                onSubmitted: (value) async {
                 setState(() {
                   genre = value;
                 });
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: bookDataList.when(
                  data: (data) {
                    return data.isEmpty ? Column(
                      children: [
                        SizedBox(height: 50.h,),
                        SizedBox(
                          height: 150.h,
                          width: 900.w,
                          child: Image.asset('assets/icons/error-graphic.png',
                            fit: BoxFit.fitHeight,),
                        ),
                        Text('No Books Found!!',
                          style: getMediumStyle(
                              color: Colors.red, fontSize: 18.sp),
                        ),
                      ],
                    ) : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return buildBook(data[index]);
                        });
                  },
                  error: (error, stackTrace) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 150.h,
                          width: 900.w,
                          child: Image.asset('assets/icons/error-graphic.png',
                            fit: BoxFit.fitHeight,),
                        ),
                        Text('No Books Found!!',
                          style: getMediumStyle(
                              color: Colors.red, fontSize: 18.sp),
                        ),
                      ],
                    );
                  },
                  loading: () {
                    return ListView.separated(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SizedBox(
                            width: double.infinity,
                            height: 90.h,
                            child: Row(
                              children: [
                                CustomShimmer(
                                  width: 60.w,
                                  height: 90.h,
                                ),
                                SizedBox(width: 20.w,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      CustomShimmer(
                                        width: 200.w,
                                        height: 18.h,
                                        borderRadius: 10.r,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      CustomShimmer(
                                        width: 120.w,
                                        height: 16.h,
                                        borderRadius: 10.r,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10.h,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBook(BookInfo book) =>
      ListTile(
        onTap: () {
          Get.to(() => BookDetailPage(bookId: book.bookID));
        },
        leading: Image.network(
          book.imagePath,
          fit: BoxFit.cover,
          height: 60.h,
          width: 40.w,
        ),
        title: Text(
          book.bookNameEnglish,
          style: getMediumStyle(color: ColorManager.black, fontSize: 16.sp),
        ),
        subtitle: Text(
          book.genres[0].genreEnglish,
          style: getRegularStyle(
              color: ColorManager.blackOpacity70, fontSize: 14.sp),
        ),
      );
}
