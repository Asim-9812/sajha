
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sajha_prakasan/src/core/resources/route_manager.dart';



class MainApp extends StatefulWidget {
  MainApp._internal(); // private named constructor
  int appState = 0;
  static final MainApp instance =
      MainApp._internal(); // single instance -- singleton

  factory MainApp() => instance; // factory for the class instance

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) {
        return const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashRoute,
        );
      },
    );
  }
}
