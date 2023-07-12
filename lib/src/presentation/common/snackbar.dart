import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';

class SnackbarUtil {
  static SnackBar showSuccessSnackbar({
    required String message,
    required Duration duration,
  }) {
    return SnackBar(
      content: Center(
        child: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 22.h,),
            const SizedBox(width: 10,),
            Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ),
      backgroundColor: ColorManager.primary,
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      margin: const EdgeInsets.fromLTRB(40, 0, 40, 120),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      duration: duration,
      dismissDirection: DismissDirection.horizontal,
      animation: CurvedAnimation(parent: kAlwaysCompleteAnimation, curve: Curves.easeOut),
    );
  }

  static SnackBar showFailureSnackbar({
    required String message,
    required Duration duration,
  }) {
    return SnackBar(
      content: Center(
          child: Row(
            children: [
              Icon(Icons.error, color: Colors.white, size: 22.h,),
              const SizedBox(width: 10,),
              Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
      ),
      backgroundColor: ColorManager.red,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(40, 0, 40, 120),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      dismissDirection: DismissDirection.horizontal,
      animation: CurvedAnimation(parent: kAlwaysCompleteAnimation, curve: Curves.easeOut),
      duration: duration,
    );
  }


  static SnackBar showWarningSnackbar({
    required String message,
  }) {
    return SnackBar(
      content: Center(
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: ColorManager.blackOpacity70,
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      duration: const Duration(milliseconds: 400),
      dismissDirection: DismissDirection.horizontal,
      animation: CurvedAnimation(parent: kAlwaysCompleteAnimation, curve: Curves.easeOut),
    );
  }

}
