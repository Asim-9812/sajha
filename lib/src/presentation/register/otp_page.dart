import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sajha_prakasan/src/presentation/auth/data/provider/auth_provider.dart';
import 'package:sajha_prakasan/src/presentation/auth/domain/auth_service.dart';
import 'package:sajha_prakasan/src/presentation/common/app_bar.dart';
import 'package:sajha_prakasan/src/presentation/common/snackbar.dart';
import 'package:sajha_prakasan/src/presentation/register/set_password.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';
import 'package:sajha_prakasan/src/core/resources/value_manager.dart';

class OTPPage extends StatefulWidget {
  final String userEmail;

  const OTPPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final int _resendDuration = 2; // Resend duration in minutes
  Timer? _timer;
  int _countdown = 0;
  bool isCountdownFinish = false;

  final _formKey = GlobalKey<FormState>();
  
  String? _otp; /// this will be used to store the otp collected from the otp fields
  

  @override
  void initState() {
    super.initState();
    _startTimer();
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _countdown = _resendDuration * 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer?.cancel();
          isCountdownFinish = true;
        }
      });
    });
  }

  String _formatDuration(int duration) {
    if (duration == 0) {
      return '2:00';
    }
    final minutes = (duration / 60).floor();
    final seconds = duration % 60;
    final paddedMinutes = minutes.toString().padLeft(2, '0');
    final paddedSeconds = seconds.toString().padLeft(2, '0');
    return '$paddedMinutes:$paddedSeconds';
  }

  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: ColorManager.white,
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppBar(
                      titleText: 'Verification',
                      hasBoxShadow: false,
                      hasArrow: true,
                    ),
                    SizedBox(
                      height: 120.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Text(
                        'We have sent an OTP (One Time Password) to ',
                        style: getSemiBoldStyle(
                            color: ColorManager.textGrey, fontSize: 18.sp),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Text(hideEmail(widget.userEmail),
                          style: TextStyle(
                            color: ColorManager.blue,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.w, vertical: 60.h),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5.w),
                              child: Text(
                                'Verification Code',
                                style: getSemiBoldStyle(
                                    color: ColorManager.black, fontSize: 18.sp),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                6,
                                (index) => SizedBox(
                                  width: 50,
                                  height: 60,
                                  child: TextFormField(
                                    controller: _controllers[index],
                                    focusNode: _focusNodes[index],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    cursorColor: ColorManager.primaryDark,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          // borderSide: BorderSide.none
                                          borderSide: BorderSide(
                                            color: ColorManager.primary
                                                .withOpacity(0.5),
                                            width: 1.5.w,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: ColorManager.primary,
                                              width: 1.5.w)),
                                      counterText: '',
                                      hintStyle: getRegularStyle(
                                          color: ColorManager.black,
                                          fontSize: 14.sp),
                                      filled: true,
                                      fillColor: ColorManager.inputGreen,
                                      isDense: true,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        if (index < 5) {
                                          _focusNodes[index + 1].requestFocus();
                                        } else {
                                          _focusNodes[index].unfocus();
                                        }
                                      } else {
                                        FocusScope.of(context).previousFocus();
                                      }
                                      setState(() {
                                        _otp = _controllers
                                            .map((controller) => controller.text)
                                            .join();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: _otp?.length == 6
                                      ? () async {
                                    final scaffoldMessege = ScaffoldMessenger.of(context);
                                          if (_formKey.currentState!.validate()) {
                                            final response = await AuthProvider().otpVerify(otp: '$_otp');
                                            if (response.success == true) {
                                              scaffoldMessege.showSnackBar(
                                                SnackbarUtil.showSuccessSnackbar(
                                                  message: '${response.msg}',
                                                  duration: const Duration(milliseconds: 1400),
                                                ),
                                              );
                                              Get.to(() => PasswordPage(userID: '${response.payload}'), transition: Transition.rightToLeft);
                                            } else {
                                              scaffoldMessege.showSnackBar(
                                                SnackbarUtil.showFailureSnackbar(
                                                  message: '${response.errors}',
                                                  duration: const Duration(milliseconds: 1600),
                                                ),
                                              );
                                              /// Clear the contents of all TextFormFields if OTP is invalid
                                              for (var controller in _controllers) {
                                                controller.clear();
                                              }
                                              setState(() {
                                                _otp = '';
                                              });
                                            }
                                          }
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    disabledBackgroundColor: ColorManager.primary.withOpacity(0.4),
                                    backgroundColor: ColorManager.primary,
                                    padding: EdgeInsets.symmetric(vertical: 16.5.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(AppSize.s15.r),
                                    ),
                                  ),
                                  child: Text(
                                    'Next',
                                    style: getMediumStyle(
                                        color: ColorManager.white,
                                        fontSize: 18.sp,
                                    ),
                                  ),
                              ),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Didn\'t get OTP',
                                  style: getMediumStyle(
                                      color: ColorManager.textGrey,
                                      fontSize: 18.sp,
                                  ),
                                ),
                            ),
                            isCountdownFinish ? Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: (_countdown == 0)
                                    ? () async {
                                  isCountdownFinish = false;
                                  _startTimer();
                                  setState(() {}); /// <-- rebuild the widget
                                  AuthService.resendOTP(email: widget.userEmail);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackbarUtil.showSuccessSnackbar(
                                        message: 'OTP Sent Successfully!',
                                        duration: const Duration(milliseconds: 1200),
                                    )
                                  );
                                }
                                : null,
                                child: Text(
                                  'Re-send Code?',
                                  style: getMediumStyle(
                                    color: ColorManager.blue,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ) :
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  'Resend code in: ${_formatDuration(_countdown)}',
                                  style: getMediumStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String hideEmail(String email) {
    List<String> parts = email.split('@');
    String username = parts[0];
    int length = username.length;
    if (length > 2) {
      String firstChar = username.substring(0, 1);
      String lastChar = username.substring(length - 1);
      String middleChars = '*' * (length - 2);
      return '$firstChar$middleChars$lastChar@${parts[1]}';
    }
    return email;
  }

}

class BuildOTPField extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;

  const BuildOTPField({
    Key? key,
    required this.controller,
    required this.autoFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      height: 60.h,
      child: TextFormField(
        autofocus: autoFocus,
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        maxLines: 1,
        textAlign: TextAlign.center,
        cursorColor: ColorManager.primaryDark,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              // borderSide: BorderSide.none
              borderSide: BorderSide(
                color: ColorManager.primary.withOpacity(0.5),
                width: 1.5.w,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: ColorManager.primary, width: 1.5.w)),
          counterText: '',
          hintStyle:
              getRegularStyle(color: ColorManager.black, fontSize: 14.sp),
          filled: true,
          fillColor: ColorManager.inputGreen,
          isDense: true,
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
