import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sajha_prakasan/src/core/utils/shimmer.dart';


import 'package:sajha_prakasan/src/presentation/book_list/presentation/book_shelve_detail.dart';

import 'package:sajha_prakasan/src/presentation/common/snackbar.dart';
import 'package:sajha_prakasan/src/presentation/favorite/data/provider/local_favorite_provider.dart';
import 'package:sajha_prakasan/src/presentation/favorite/presentation/provider/favorite_book_provider.dart';
import 'package:sajha_prakasan/src/presentation/login/domain/model/user.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';

import '../data/provider/book_list_provider.dart';

class BookShelvePage extends ConsumerStatefulWidget {
  const BookShelvePage({Key? key}) : super(key: key);

  @override
  ConsumerState<BookShelvePage> createState() => _BookShelvePageState();
}

class _BookShelvePageState extends ConsumerState<BookShelvePage> {


  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box<User>('session').values.toList();
    final favList = ref.watch(favListProvider);
    final subscribedBookList = ref.watch(bookListProvider(userBox[0].userID));


    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        shadowColor: ColorManager.blackOpacity25,
        scrolledUnderElevation: 5.0,
        title: const Text('My Books'),
        titleTextStyle: getSemiBoldStyle(color: ColorManager.black, fontSize: 24.sp),
      ),
      body: subscribedBookList.when(
          data: (data) {
            return data.isEmpty ? Column(
              children: [
                SizedBox(height: 50.h,),
                Center(child: Image.asset('assets/icons/no-books.png', height: 300.h, width: 350.w,)),
                Text('Subscribe',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontFamily: 'Lato',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                    ),
                ),
                Text('Some',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontFamily: 'Lato',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400
                    ),
                ),
                Text('BOOKS',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontFamily: 'Lato',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                    ),
                ),
              ],
            ) : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final bookListData = data[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => MyBookDetailPage(purchasedBook: bookListData), transition: Transition.downToUp, curve: Curves.fastOutSlowIn,);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                          height: 160.h,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    bookListData.imagePath!,
                                    height: double.infinity,
                                    width: 100.w,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(width: 10.w,),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5.h,),
                                          Text(bookListData.bookNameNepali!, style:  getSemiBoldStyle(color: ColorManager.black, fontSize: 18.sp), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                          SizedBox(height: 2.h,),
                                          Text(bookListData.authors![0].authorNameNepali!, style: getMediumStyle(color: ColorManager.textGrey, fontSize: 14.sp),),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Container(
                                                height: 24.h,
                                                width: 70.w,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xffeeeeee),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(child: Text('Edition ${bookListData.edition}', style: getMediumStyle(color: Colors.black.withOpacity(0.65), fontSize: 12.sp),)),
                                              ),
                                              const Spacer(),
                                              const Text('⭐⭐⭐⭐⭐'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                right: -5.w,
                                top: -15.h,
                                child: Material(
                                  elevation: 0.0,
                                  color: Colors.transparent,
                                  child: favList.contains(data[index].bookID) ? IconButton(
                                      onPressed: _isLoading ? null : () async {
                                        final scaffoldMessage = ScaffoldMessenger.of(context);
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        final result = await ref.read(removeFavBookProvider).removeFavBook(bookId: data[index].bookID!);
                                        scaffoldMessage.clearSnackBars();
                                        if(result != 'success'){
                                          scaffoldMessage.showSnackBar(
                                              SnackbarUtil.showFailureSnackbar(message: result, duration: const Duration(milliseconds: 1200))
                                          );
                                        }else{
                                          ref.read(favListProvider.notifier).removeItem(data[index].bookID!, favList.indexOf(data[index].bookID!));
                                          ref.refresh(favoriteBooksProvider);
                                          ref.read(favoriteBooksProvider);
                                          scaffoldMessage.showSnackBar(
                                              SnackbarUtil.showSuccessSnackbar(message: 'Removed from Favorites', duration: const Duration(milliseconds: 1200))
                                          );
                                        }
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
                                        size: 24,
                                        color: Colors.red,
                                      )) :
                                  IconButton(
                                    onPressed: _isLoading ? null : () async {
                                      final scaffoldMessage = ScaffoldMessenger.of(context);
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      final result = await ref.read(addFavoriteProvider).addBookToFavorite(bookId: data[index].bookID!);
                                      if (result != 'success') {
                                        scaffoldMessage.showSnackBar(
                                            SnackbarUtil.showFailureSnackbar(message: result,
                                                duration: const Duration(milliseconds: 1200))
                                        );
                                      } else {
                                        ref.read(favListProvider.notifier).addToFavorite(data[index].bookID!, data[index].bookID!);
                                      }
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    },
                                    icon: Icon(Icons.favorite_outline, color: Colors.black87, size: 30.h,),
                                  ),
                                ),
                              )
                            ],
                          )
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20.h,
                    ),
                  ),
                ),
              ],
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
