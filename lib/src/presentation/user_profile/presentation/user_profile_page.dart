import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sajha_prakasan/src/presentation/favorite/presentation/page/favorite_page.dart';


import 'package:sajha_prakasan/src/presentation/login/domain/model/user.dart';
import 'package:sajha_prakasan/src/presentation/login/presentation/page/status_page.dart';
import 'package:sajha_prakasan/src/presentation/login/presentation/provider/user_provider.dart';

import 'package:sajha_prakasan/src/presentation/common/app_bar.dart';


import 'package:sajha_prakasan/src/presentation/user_profile/presentation/account_setting_page.dart';
import 'package:sajha_prakasan/src/presentation/user_profile/presentation/change_password.dart';
import 'package:sajha_prakasan/src/presentation/user_profile/presentation/provider/user_image_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';


class UserProfileView extends ConsumerWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userBox = Hive.box<User>('session').values.toList();
    final currentUser = userBox[0];
    final image = ref.watch(imageProvider);
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(titleText: 'Profile', hasBoxShadow: true, hasArrow: false,),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  child: Consumer(
                    builder: (context, ref, child) {
                      // final profilePic = '${Api.baseUrl}${currentUser.profileUrl!}';
                      return Column(
                        children: [
                          SizedBox(height: 20.h,),
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 70.r,
                                backgroundColor: ColorManager.brightGreen,
                                child: ClipOval(
                                  child: showImage(currentUser, image),
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () async {
                                    final box = Hive.box<String>('tokenBox');
                                    final accessToken = box.get('accessToken');
                                    await ref.read(userProvider.notifier).getUserInfo(token: accessToken!);
                                    Get.to(() => const EditProfilePage(), transition: Transition.rightToLeft);
                                  },
                                  child: Container(
                                    height: 36.h,
                                    width: 36.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30.r),
                                        border: Border.all(
                                            color: Colors.white,
                                            width: 2.w
                                        )
                                    ),
                                    child: Badge(
                                      label: Icon(Icons.edit_outlined, color: Colors.white, size: 20.h,),
                                      backgroundColor: Colors.blue,
                                      largeSize: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            '${currentUser.firstName} ${currentUser.lastName}',
                            style: getSemiBoldStyle(
                                color: ColorManager.black, fontSize: 26.sp),
                          ),
                          Text(
                            currentUser.email,
                            style: getRegularStyle(
                                color: ColorManager.black, fontSize: 18.sp),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          const Divider(
                            thickness: 2.5,
                          ),
                          SizedBox(
                            height: 27.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Favourite',
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black, fontSize: 20.sp),
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                ListTile(
                                  onTap: () {
                                    Get.to(() => const FavoritePage());
                                  },
                                  leading: Icon(Icons.favorite_outline, size: 25, color: ColorManager.iconGrey,
                                  ),
                                  title: Text('Favorite Books', style: getMediumStyle(color: ColorManager.black, fontSize: 16.sp),),
                                  minLeadingWidth: 20.w,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                                  tileColor: ColorManager.listTile,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Account',
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black, fontSize: 20.sp),
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                buildListTile(context,icon: Icons.key, title: 'Change Password', id: 2),
                                SizedBox(
                                  height: 7.h,
                                ),
                                // buildListTile(context, title: 'Change Profile', icon: Icons.person, id: )
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Settings',
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black, fontSize: 20.sp),
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                buildListTile(context,icon: Icons.credit_card, title: 'Change Subscription', id: 3),
                                SizedBox(height: 7.h,),
                                buildListTile(context,icon: Icons.language, title: 'Language', id: 4),
                                SizedBox(height: 7.h,),
                                buildListTile(context,icon: Icons.privacy_tip, title: 'Permission', id: 5),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Offers',
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black, fontSize: 20.sp),
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                buildListTile(context,icon: CupertinoIcons.tickets, title: 'Promos', id: 6),
                                SizedBox(height: 7.h,),
                                buildListTile(context,icon: Icons.discount, title: 'Referral and Discount', id: 7),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Transaction',
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black, fontSize: 20.sp),
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                buildListTile(context,icon: Icons.history, title: 'Transaction History', id: 8),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Help & Legal',
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black, fontSize: 20.sp),
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                buildListTile(context, icon: Icons.emergency, title: 'Emergency Support', id: 9),
                                SizedBox(height: 7.h,),
                                buildListTile(context, icon: Icons.help_outline_sharp, title: 'Help', id: 10),
                                SizedBox(height: 7.h,),
                                buildListTile(context, icon: Icons.policy_outlined, title: 'Policies', id: 11),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'More',
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black, fontSize: 20.sp),
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                buildListTile(context, icon: Icons.star, title: 'Rate Us', id: 12),
                              ],
                            ),
                          ),
                          SizedBox(height: 25.h,),
                          Consumer(
                            builder: (context, ref, child) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25),
                                child: ListTile(
                                  onTap: () {
                                    ref.read(userProvider.notifier).userLogout();
                                    Get.to(() => const StatusPage());
                                  },
                                  leading: Icon(Icons.logout, size: 25, color: ColorManager.iconGrey,
                                  ),
                                  title: Text('Log out', style: getMediumStyle(color: ColorManager.black, fontSize: 16.sp),),
                                  minLeadingWidth: 20.w,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                                  tileColor: ColorManager.listTile,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 30.h,),
                          Text('Follow Us', style: TextStyle(fontFamily: 'Lato', fontSize: 16.sp, fontWeight: FontWeight.w500, decoration: TextDecoration.underline),),
                          SizedBox(height: 20.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _launchFacebookProfile('sajhaprakashannepal');
                                },
                                child: SizedBox(
                                    height: 40.h,
                                    width: 40.h,
                                    child: Image.asset('assets/icons/facebook.png', fit: BoxFit.cover,)
                                ),
                              ),
                              SizedBox(width: 20.w,),
                              SizedBox(
                                  height: 40.h,
                                  width: 40.h,
                                  child: Image.asset('assets/icons/instagram.png', fit: BoxFit.cover,)
                              ),
                              SizedBox(width: 20.w,),
                              SizedBox(
                                  height: 40.h,
                                  width: 40.h,
                                  child: Image.asset('assets/icons/twitter.png', fit: BoxFit.cover,)
                              ),
                            ],
                          ),
                          SizedBox(height: 49.h,),
                          Text('Version 1.0.0', style: getRegularStyle(color: ColorManager.black, fontSize: 14.sp),),
                          Text('Developed By Search Technology', style: getRegularStyle(color: ColorManager.black, fontSize: 14.sp),),
                          SizedBox(height: 20.h,)
                        ],
                      );
                    },
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



  Future<void> _launchFacebookProfile(String username) async {
    final String scheme = 'fb://facewebmodal/f?href=https://www.facebook.com/$username';
    final Uri uri = Uri.parse(scheme);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }




  ListTile buildListTile(BuildContext context, {required String title, required IconData icon, required int id}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
        color: ColorManager.iconGrey,
      ),
      title: Text(
        title,
        style: getMediumStyle(color: ColorManager.black, fontSize: 16.sp),
      ),
      onTap: () {
        int tileId = id;
        switch(tileId){
          // case 1:
          //   Get.to(() => const FavoritePage());
          //   break;
          case 2:
            Get.to(() => const ChangePasswordView(), transition: Transition.rightToLeft);
            break;
          case 3:
            //Get.to(() => const ChangeSubscriptionPage(), transition: Transition.rightToLeft);
            break;
          case 4:
            break;
          case 5:
            break;
          case 6:

            break;
          case 7:

            break;
          case 8:
            //Get.to(() => const PaymentHistoryPage(), transition: Transition.rightToLeft);
            break;
          case 9:

            break;
          case 10:

            break;
          case 11:

            break;
          case 12:

            break;
        }
      },
      minLeadingWidth: 20.w,
      contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
      tileColor: ColorManager.listTile,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.r),
      ),
    );
  }
}
