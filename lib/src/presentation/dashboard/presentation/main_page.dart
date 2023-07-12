
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajha_prakasan/src/presentation/book_list/presentation/new_book_list.dart';
import 'package:sajha_prakasan/src/presentation/common/snackbar.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/presentation/home_page_screen.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/screens/notification_page.dart';
import 'package:sajha_prakasan/src/presentation/user_profile/presentation/user_profile_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';




class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with SingleTickerProviderStateMixin {

  TabController? _tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }


  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if(isExitWarning){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackbarUtil.showWarningSnackbar(message: 'Press back again to exit app')
          );
          return false;
        } else{
          return true;
        }
      },
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: const [
            HomePageView(),
            // MyBooksView(),
            BookShelvePage(),
            NotificationView(),
            UserProfileView(),
          ],
        ),

        bottomNavigationBar: Material(
          color: Colors.white,
          elevation: 10.0,
          shadowColor: Colors.black,
          child: TabBar(
            controller: _tabController,
              labelColor: ColorManager.brightGreen,
              unselectedLabelColor: ColorManager.textGrey,
              isScrollable: false,
              indicatorColor: ColorManager.brightGreen,
              labelStyle: getSemiBoldStyle(
                  color: ColorManager.textGrey, fontSize: 16.sp),
              unselectedLabelStyle: getMediumStyle(
                  color: ColorManager.textGrey, fontSize: 16.sp),
              indicator: BoxDecoration(
                color: ColorManager.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              tabs: [
                Tab(
                  height: 50.h,
                  icon: const FaIcon(FontAwesomeIcons.house),
                ),
                Tab(
                  height: 50.h,
                  icon: const FaIcon(FontAwesomeIcons.book),
                ),
                Tab(
                  height: 50.h,
                  icon: const FaIcon(FontAwesomeIcons.solidBell),
                ),
                Tab(
                  height: 50.h,
                  icon: const FaIcon(FontAwesomeIcons.solidUser),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
