import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.titleText, required this.hasBoxShadow, required this.hasArrow,}) : super(key: key);
  final String titleText;
  final bool hasBoxShadow;
  final bool hasArrow;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(64.h),
      child: Container(
        height: 64.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorManager.white.withAlpha(500),
          boxShadow: [
            hasBoxShadow ?
            BoxShadow(
              color: ColorManager.blackOpacity15,
              offset: const Offset(0.0, 1.0),
              // blurRadius: 1.0,
            ) : BoxShadow(
              color: ColorManager.white,
              offset: const Offset(0.0, 0.0),
            )
          ]
        ),
        child: hasArrow ? Row(
          children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios_new_rounded, size: 30.h, color: ColorManager.black,)
              ),
          ),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, right: 50.w),
                  child: Center(child: Text(titleText, style: getSemiBoldStyle(color: ColorManager.black, fontSize: 22.sp),)),
                ),
            ),
          ],
        ) : Center(
          child: Text(titleText, style: getSemiBoldStyle(color: ColorManager.black, fontSize: 22.sp),
          ),
        ),
      ),
    );
  }
}
