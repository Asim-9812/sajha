

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajha_prakasan/src/presentation/login/presentation/page/status_page.dart';

import 'package:sajha_prakasan/src/core/resources/color_manager.dart';

import 'package:page_transition/page_transition.dart';

class SplashView extends ConsumerWidget {
  const SplashView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        )
    );

    return AnimatedSplashScreen(
      backgroundColor: ColorManager.primaryOpacity80,
      splash: 'assets/images/Splash-logo.png',
      nextScreen: const StatusPage(),
      splashIconSize: 120.h,
      centered: true,
      curve: Curves.linear,
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.fade,
      duration: 3000,
    );
  }
}
