import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';



class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView>
    with TickerProviderStateMixin {
  TabController? _tabController;

  Color tileColor = ColorManager.greenNotification;
  Color tile2Color = ColorManager.greenNotification;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: const Text('Notifications'),
          titleTextStyle: getSemiBoldStyle(color: ColorManager.black, fontSize: 22),
          toolbarHeight: 70,
          bottom: TabBar(
            controller: _tabController,
            labelColor: ColorManager.black,
            unselectedLabelColor: ColorManager.textGrey,
            indicatorColor: ColorManager.brightGreen,
            indicatorWeight: 4,
            labelStyle: getSemiBoldStyle(
                color: ColorManager.textGrey, fontSize: 20.sp),
            unselectedLabelStyle: getMediumStyle(
                color: ColorManager.textGrey, fontSize: 20.sp),
            tabs: const [
              Tab(
                text: 'General',

              ),
              Tab(
                text: 'Personal',
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(controller: _tabController, children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            tileColor = ColorManager.white;
                          });
                        },
                        child: Text(
                          'Mark all as read',
                          style: getMediumStyle(
                              color: ColorManager.blue,
                              fontSize: 14.sp),
                        )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                 Expanded(
                   child: ListView(
                     children: [
                       buildContainer(
                         title: 'Sajha Prakasan',
                         subtitle:
                         ' start from february 3rd, register to get early ac..',
                         time: 'Yesterday',
                         color: tileColor,
                       ),
                       SizedBox(
                         height: 15.h,
                       ),
                       buildContainer(
                           title: 'Sajha Prakasan',
                           subtitle:
                           ' 12% off on all the academic books available for students with college id and...',
                           time: '5 days ago',
                           color: tileColor
                       ),
                       SizedBox(
                         height: 15.h,
                       ),
                       buildContainer(
                         title: 'Sajha Prakasan',
                         subtitle:
                         ' to be released in auspicious occasion of new year...',
                         time: '23 m ago',
                         color: tileColor,
                       ),
                       SizedBox(
                         height: 15.h,
                       ),
                       buildContainer(
                         title: 'Sajha Prakasan',
                         subtitle:
                         ' start from february 3rd, register to get early ac..',
                         time: 'Yesterday',
                         color: tileColor,
                       ),
                       SizedBox(
                         height: 15.h,
                       ),
                       buildContainer(
                           title: 'Sajha Prakasan',
                           subtitle:
                           ' 12% off on all the academic books available for students with college id and...',
                           time: '5 days ago',
                           color: tileColor
                       ),
                       SizedBox(
                         height: 15.h,
                       ),
                     ],
                   ),
                 )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            tile2Color = ColorManager.white;
                          });
                        },
                        child: Text(
                          'Mark all as read',
                          style: getMediumStyle(
                              color: ColorManager.blue,
                              fontSize: 14.sp),
                        )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        buildContainer(
                            title: 'Maximus Collen',
                            subtitle:
                            ' The new book about the health and physics is very handy! I am following it and its fantastic',
                            time: '9 m ago',
                            imageUrl:
                            'https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                            color: tile2Color
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        buildContainer(
                            title: 'Anthony Mitchell',
                            subtitle:
                            ' the conspiracy theory in 1954 by russian agency and the anti gorvernment is very looking dangerours alks asdue re',
                            time: '3 days ago',
                            imageUrl:
                            'https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fHBlcnNvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
                            color: tile2Color
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        buildContainer(
                            title: 'Aisha Abdallah',
                            subtitle:
                            ' fantastic beast series. it is very interesting and so..',
                            time: 'last month',
                            imageUrl:
                            'https://images.unsplash.com/photo-1626943789936-09fcc6cf58ff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fG11c2xpbSUyMHdvbWVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                            color: tile2Color
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        buildContainer(
                            title: 'Maximus Collen',

                            subtitle:
                            ' The new book about the health and physics is very handy! I am following it..',
                            time: '9 m ago',
                            imageUrl:
                            'https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                            color: tile2Color
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        buildContainer(
                            title: 'Anthony Mitchell',
                            subtitle:
                            ' the conspiracy theory in 1954 by russian agency and the anti gorvernment is very looking dangerours alks asdue re',
                            time: '3 days ago',
                            imageUrl:
                            'https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fHBlcnNvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
                            color: tile2Color
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        buildContainer(
                            title: 'Aisha Abdallah',
                            subtitle:
                            ' fantastic beast series. it is very interesting and so..',
                            time: 'last month',
                            imageUrl:
                            'https://images.unsplash.com/photo-1626943789936-09fcc6cf58ff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fG11c2xpbSUyMHdvbWVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                            color: tile2Color
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ])
        ),
      ),
    );
  }

  Container buildContainer({required String title, required subtitle, required String time, String? imageUrl, Key? key, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: imageUrl != null ? Image.network(imageUrl).image : const AssetImage('assets/images/sajha_logo.jpg'),
            backgroundColor: Colors.white,
            radius: 30.r,
          ),
          const SizedBox(width: 15,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(text: title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.black),),
                        TextSpan(text: subtitle, style: TextStyle(fontSize: 16.sp, color: Colors.black.withOpacity(0.7),))
                      ]
                  ),
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(Icons.access_time_outlined, size: 20.h, color: ColorManager.iconGrey.withOpacity(0.4),),
                    SizedBox(width: 5.w,),
                    Text('2 hours ago', style: TextStyle(fontSize: 14.sp, color: ColorManager.subtitleGrey.withOpacity(0.6), fontWeight: FontWeight.w400),)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
