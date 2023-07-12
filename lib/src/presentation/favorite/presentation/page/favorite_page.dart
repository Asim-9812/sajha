import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:sajha_prakasan/src/core/utils/shimmer.dart';

import 'package:sajha_prakasan/src/presentation/common/snackbar.dart';
import 'package:sajha_prakasan/src/presentation/detail/presentation/pages/new_detail_page.dart';
import 'package:sajha_prakasan/src/presentation/favorite/data/provider/local_favorite_provider.dart';
import 'package:sajha_prakasan/src/presentation/favorite/presentation/provider/favorite_book_provider.dart';

import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';



class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {


  bool _isLoad = false;


  @override
  Widget build(BuildContext context) {
    final favList = ref.watch(favListProvider);
    final favBooks = ref.watch(favoriteBooksProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 30.h, color: ColorManager.black,)
        ),
        title: const Text('Favorite books'),
        titleTextStyle: getSemiBoldStyle(color: ColorManager.black, fontSize: 22.sp),
        shadowColor: ColorManager.blackOpacity15,
      ),
      body: favBooks.when(
        data: (data) {
          return data.isEmpty ? Column(
            children: [
              SizedBox(height: 50.h,),
              Center(child: Image.asset('assets/icons/no-books.png', height: 300.h, width: 350.w,)),
              Text('Add some Books',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.sp,
                  fontFamily: 'Lato',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ) : ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => BookDetailPage(bookId: data[index].bookID!),
                    transition: Transition.downToUp, curve: Curves.fastOutSlowIn,);
                },
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                      height: 180.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.blackOpacity15,
                            offset: const Offset(0.0, 2.0),
                            blurRadius: 2.0,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            data[index].imagePath!,
                            height: double.infinity,
                            width: 100.w,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 15.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data[index].bookNameEnglish!,
                                    style: getSemiBoldStyle(
                                        color: ColorManager.black, fontSize: 20.sp),),
                                  SizedBox(height: 2.h,),
                                  Text('By ${data[index].publisherName}',
                                    style: getMediumStyle(
                                        color: ColorManager.textGrey,
                                        fontSize: 14.sp),),
                                  const Spacer(),
                                  Text('${data[index]
                                      .tFavourite} people likes this book',
                                    style: getMediumStyle(
                                        color: ColorManager.textGrey,
                                        fontSize: 14.sp),),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: List.generate(
                                                data[index].avgRating!.floor(), (
                                                index) =>
                                            const Icon(
                                              Icons.star, color: Color(0xffffc700),)),
                                          ),
                                          Row(
                                            children: List.generate(
                                                (data[index].avgRating! % 1) == 0
                                                    ? 0
                                                    : 1, (index) =>
                                            const Icon(Icons.star_half,
                                              color: Color(0xffffc700),)),
                                          ),
                                          Row(
                                            children: List.generate(
                                                (5 - data[index].avgRating!)
                                                    .floor(), (index) =>
                                            const Icon(Icons.star_border,
                                              color: Color(0xffffc700),)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 5.w,),
                                      Text(
                                          (data[index].avgRating!).toStringAsFixed(1))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Material(
                        elevation: 0.0,
                        child: IconButton(
                            onPressed: _isLoad ? null : () async {
                              final scaffoldMessage = ScaffoldMessenger.of(context);
                              setState(() {
                                _isLoad = true;
                              });
                              final result = await ref.read(removeFavBookProvider).removeFavBook(bookId: data[index].bookID!);
                              scaffoldMessage.clearSnackBars();
                              if(result != 'success'){
                                scaffoldMessage.showSnackBar(
                                    SnackbarUtil.showFailureSnackbar(message: result, duration: const Duration(milliseconds: 1200))
                                );
                              }else{
                                ref.read(favListProvider.notifier).removeItem(data[index].bookID!,favList.indexOf(data[index].bookID!));
                                ref.refresh(favoriteBooksProvider);
                                ref.read(favoriteBooksProvider);
                                scaffoldMessage.showSnackBar(
                                    SnackbarUtil.showSuccessSnackbar(message: 'Removed from Favorites', duration: const Duration(milliseconds: 1200))
                                );
                              }
                              setState(() {
                                _isLoad = false;
                              });
                            },
                            icon: const Icon(
                              Icons.favorite,
                              size: 24,
                              color: Colors.red,
                            )),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) =>
                SizedBox(
                  height: 20.h,
                ),
          );
        },
        error: (error, stackTrace) => Center(child: Text('$error'),),
        loading: () {
          return ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                height: 160.h,
                width: double.infinity,
                child: Row(
                  children: [
                    CustomShimmer(
                      width: 100.w,
                      height: double.infinity,
                      borderRadius: 16.r,
                    ),
                    SizedBox(width: 10.w,),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomShimmer(width: double.infinity, height: 30.h, borderRadius: 10.r,),
                            SizedBox(height: 5.h,),
                            CustomShimmer(width: 120.w, height: 22.h, borderRadius: 10.r,),
                            const Spacer(),
                            Row(
                              children: [
                                CustomShimmer(width: 100.w, height: 30.h, borderRadius: 5.r,),
                                const Spacer(),
                                CustomShimmer(width: 100.w, height: 20.h, borderRadius: 16.r,)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      )
    );
  }
}
