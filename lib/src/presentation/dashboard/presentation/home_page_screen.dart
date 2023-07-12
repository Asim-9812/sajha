import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sajha_prakasan/src/core/utils/shimmer.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/data/provider/carousel_provider.dart';

import 'package:sajha_prakasan/src/presentation/common/cart_badge.dart';
import 'package:sajha_prakasan/src/presentation/common/snackbar.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/data/provider/book_providers.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/search/presentation/search_page.dart';
import 'package:sajha_prakasan/src/presentation/detail/presentation/pages/new_detail_page.dart';
import 'package:sajha_prakasan/src/presentation/favorite/data/provider/local_favorite_provider.dart';
import 'package:sajha_prakasan/src/presentation/favorite/presentation/provider/favorite_book_provider.dart';
import 'package:sajha_prakasan/src/presentation/genre_search/presentation/genre_search_page.dart';
import 'package:sajha_prakasan/src/presentation/login/domain/model/user.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';


class HomePageView extends ConsumerStatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends ConsumerState<HomePageView> {

  final CarouselController _carouselController = CarouselController();
  int currentIndex = 0;

  bool? isSelected;

  String selectedChip = 'All';

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final sliderData = ref.watch(carouselProvider);
    final bookList = ref.watch(bookProvider);
    final isBookLoading = ref.watch(bookProvider).isLoad;
    final favList = ref.watch(favListProvider);
    final userBox = Hive.box<User>('session').values.toList();

    String firstName = userBox[0].firstName;

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: true,
              centerTitle: false,
              backgroundColor: ColorManager.white.withAlpha(500),
              title: Text(
                'Welcome, $firstName',
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark, fontSize: 24.sp),
              ),
              leadingWidth: 0,
              actions: const [
                CartBadge()
              ],
              scrolledUnderElevation: 1,
              expandedHeight: 140.h,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Get.to(() => const SearchBookPage(),
                              transition: Transition.downToUp);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 20.w, right: 5.w),
                          height: 52.h,
                          width: 400.w,
                          decoration: BoxDecoration(
                            color: ColorManager.inputGreen,
                            borderRadius: BorderRadius.circular(15.r)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Search Books', style: getRegularStyle(color: ColorManager.textGrey, fontSize: 16.sp),),
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(CupertinoIcons.search, color: ColorManager.iconGrey, size: 28.h,)
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                   SizedBox(height: 15.h,)
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 20.h,),
             sliderData.when(
                 data: (carousal) {
                   return Column(
                     children: [
                       InkWell(
                         onTap: () {},
                         child: CarouselSlider(
                           items: carousal
                               .map(
                                 (item) => Center(
                               child: ClipRRect(
                                 borderRadius: BorderRadius.circular(15.r),
                                 child: Image.network(
                                   '${item.imageUrl}',
                                   fit: BoxFit.cover,
                                   width: 1000.w,
                                 ),
                               ),
                             ),
                           ).toList(),
                           carouselController: _carouselController,
                           options: CarouselOptions(
                             enlargeCenterPage: true,
                             height: 180.h,
                             initialPage: 1,
                             scrollPhysics: const BouncingScrollPhysics(),
                             autoPlay: true,
                             aspectRatio: 2.0,
                             reverse: false,
                             viewportFraction: 0.85,
                             onPageChanged: (index, reason) {
                               setState(() {
                                 currentIndex = index;
                               });
                             },
                           ),
                         ),
                       ),
                       SizedBox(height: 20.h,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: carousal.asMap().entries.map((entry) {
                           return GestureDetector(
                             onTap: () =>
                                 _carouselController.animateToPage(entry.key),
                             child: AnimatedContainer(
                               curve: Curves.easeIn,
                               duration: const Duration(milliseconds: 500),
                               width: currentIndex == entry.key ? 18 : 10,
                               height: 10,
                               margin: EdgeInsets.symmetric(horizontal: 2.w),
                               decoration: BoxDecoration(
                                   color: currentIndex == entry.key
                                       ? ColorManager.primary
                                       : ColorManager.dotGrey,
                                   borderRadius: BorderRadius.circular(50)),
                             ),
                           );
                         }).toList(),
                       ),
                     ],
                   );
                 },
                 error: (error, stackTrace) {
                   return Column(
                       children: [
                         SizedBox(
                           height: 180.h,
                           width: 1000.w,
                           child: Image.asset('assets/icons/error-graphic.png', fit: BoxFit.fitHeight,),
                         ),
                         Text('No Slider Found!!',
                           style: getMediumStyle(color: Colors.red, fontSize: 18.sp),
                         ),
                       ],
                   );
                 },
                 loading: () {
                   return CustomShimmer(
                     width: 400.w,
                     height: 200.h,
                     borderRadius: 15.r,
                   );
                 },
             ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: getMediumStyle(
                          color: ColorManager.black, fontSize: 20.sp),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const GenreSearchPage());
                      },
                      child: Text('View all',
                          style: getMediumStyle(
                              color: ColorManager.blue, fontSize: 16.sp)),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Theme(
                  data: ThemeData(
                    chipTheme: ChipThemeData(
                      backgroundColor: ColorManager.chipColor,
                      labelStyle: TextStyle(color: const Color(0xff7E7E7E), fontSize: 15.sp),
                      secondaryLabelStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                      selectedColor: ColorManager.primary,
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r), // Decrease the border radius here
                      ),
                    )
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20.w,),
                      ChoiceChip(
                        label: const Text('All'),
                        selected: selectedChip == 'All',
                        onSelected: (selected) {
                          setState(() {
                            selectedChip = 'All';
                          });
                          ref.read(bookProvider.notifier).changeCategory(apiPath: Api.bookInfo);
                        },

                      ),
                      SizedBox(width: 15.w,),
                      ChoiceChip(
                        label: const Text('Recommended'),
                        selected: selectedChip == 'Recommended',
                        onSelected: (selected) {
                          setState(() {
                            selectedChip = 'Recommended';
                          });
                          ref.read(bookProvider.notifier).changeCategory(apiPath: Api.getRecommendedBooks);
                        },
                      ),
                      SizedBox(width: 15.w,),
                      ChoiceChip(
                        label: const Text('Latest'),
                        selected: selectedChip == 'Latest',
                        onSelected: (selected) {
                          setState(() {
                            selectedChip = 'Latest';
                          });
                          ref.read(bookProvider.notifier).changeCategory(apiPath: Api.getLatestBooks);
                        },
                      ),
                      SizedBox(width: 15.w,),
                      ChoiceChip(
                        label: const Text('Best Seller'),
                        selected: selectedChip == 'Best Seller',
                        onSelected: (selected) {
                          setState(() {
                            selectedChip = 'Best Seller';
                          });
                          ref.read(bookProvider.notifier).changeCategory(apiPath: Api.getBestSellingBooks);
                        },
                      ),
                      SizedBox(width: 15.w,),
                      ChoiceChip(
                        label: const Text('Premium'),
                        selected: selectedChip == 'Premium',
                        onSelected: (selected) {
                          setState(() {
                            selectedChip = 'Premium';
                          });
                          ref.read(bookProvider.notifier).changeCategory(apiPath: Api.getPremiumBooks);
                        },
                      ),
                      SizedBox(width: 15.w,),
                      ChoiceChip(
                        label: const Text('Freemium'),
                        selected: selectedChip == 'Free',
                        onSelected: (selected) {
                          setState(() {
                            selectedChip = 'Free';
                          });
                          ref.read(bookProvider.notifier).changeCategory(apiPath: Api.getFreeBooks);
                        },
                      ),
                      SizedBox(width: 15.w,)
                    ],
                  ),
                ),
              ),
            GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 15.h,
                mainAxisExtent: 300.h,
              ),
              itemCount: isBookLoading ? 6 : bookList.books.length,
              itemBuilder: (context, index) {
                final bookData = bookList.books;
                // print(favList.contains(FavoriteList(bookId: bookData[index].bookID)));
                return isBookLoading == true ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmer(width: 150.w, height: 240.h, borderRadius: 20.r,),
                    const Spacer(),
                    CustomShimmer(width: 80.w, height: 22.h, borderRadius: 5.r,),
                    const Spacer(),
                    CustomShimmer(width: 60.w, height: 16.h, borderRadius: 5.r,)
                  ],
                ) :
                InkWell(
                  onTap: () => Get.to(() => BookDetailPage(bookId: bookData[index].bookID),
                      transition: Transition.rightToLeft, curve: Curves.linear),
                  child: Container(
                    width: 170.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorManager.borderGreen, width: 1.w)),
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            SizedBox(
                              height: 153.h,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 19.h),
                              child: Align(
                                alignment: AlignmentDirectional.center,
                                child: Image.network(bookData[index].imagePath, height: 160.h, width: 120.w, fit: BoxFit.contain,)
                              ),
                            ),
                            Positioned(
                              right: -8,
                              top: -6,
                              child: favList.contains(bookData[index].bookID) ? IconButton(
                                  onPressed: _isLoading ? null :  () async {
                                    final scaffoldMessage = ScaffoldMessenger.of(context);
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    final result = await ref.read(removeFavBookProvider).removeFavBook(bookId: bookData[index].bookID);
                                    scaffoldMessage.clearSnackBars();
                                    if(result != 'success'){
                                      if(favList.contains(bookData[index].bookID)){
                                        ref.read(favListProvider.notifier).removeItem(bookData[index].bookID, favList.indexOf(bookData[index].bookID));
                                      }else{
                                        scaffoldMessage.showSnackBar(
                                            SnackbarUtil.showFailureSnackbar(message: result, duration: const Duration(milliseconds: 500))
                                        );
                                      }
                                    } else {
                                      ref.read(favListProvider.notifier).removeItem(bookData[index].bookID, favList.indexOf(bookData[index].bookID));
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
                                  final result = await ref.read(addFavoriteProvider).addBookToFavorite(bookId: bookData[index].bookID);
                                  if (result != 'success') {
                                    scaffoldMessage.showSnackBar(
                                        SnackbarUtil.showFailureSnackbar(message: result,
                                            duration: const Duration(milliseconds: 500))
                                    );
                                  } else {
                                    ref.read(favListProvider.notifier).addToFavorite(bookData[index].bookID, bookData[index].bookID);
                                  }
                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                                icon: Icon(Icons.favorite_outline, color: Colors.black87, size: 30.h,),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bookData[index].bookNameNepali,
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'By ${bookData[index].publisherName}',
                                style: getRegularStyle(
                                  color: ColorManager.black,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                '${bookData[index].tFavourite} people likes this book',
                                style: getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const Spacer(),
                        Container(
                          height: 40.h,
                          width: 137.w,
                          padding: EdgeInsets.zero,
                          child: Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: TextButton(
                                onPressed: () {
                                  Get.to(() => BookDetailPage(bookId: bookData[index].bookID));
                                },
                                child: Text(
                                  'Read more',
                                  style: getRegularStyle(
                                      color: ColorManager.blue, fontSize: 14.sp),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            ],
          ),
        ),
      ),
    );
  }
}
