import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sajha_prakasan/src/presentation/register/otp_page.dart';
import 'package:sajha_prakasan/src/presentation/common/snackbar.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';
import 'package:sajha_prakasan/src/core/resources/value_manager.dart';

import '../../common/app_bar.dart';

class AddPhoneNumPage extends StatefulWidget {
  const AddPhoneNumPage({Key? key}) : super(key: key);

  @override
  State<AddPhoneNumPage> createState() => _AddPhoneNumPageState();
}

class _AddPhoneNumPageState extends State<AddPhoneNumPage> {
  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();
  final _countryCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _countryCodeController.text = '+977';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                    titleText: 'Add Phone',
                    hasBoxShadow: true,
                    hasArrow: true,
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 33.w),
                    child: Text(
                      'Add your phone number',
                      style: getMediumStyle(
                          color: ColorManager.textGrey, fontSize: 18.sp),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 46.w, vertical: 64.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(
                              'Phone',
                              style: getMediumStyle(
                                  color: ColorManager.black, fontSize: 16.sp),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            height: 55.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: ColorManager.inputGreen,
                                borderRadius: BorderRadius.circular(15.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Country code is required';
                                        }
                                        return null;
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: _countryCodeController,
                                      keyboardType: TextInputType.phone,
                                      textAlign: TextAlign.center,
                                      style: getRegularStyle(
                                          color: ColorManager.black,
                                          fontSize: 16.sp),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    '|',
                                    style: getRegularStyle(
                                        color: ColorManager.dotGrey,
                                        fontSize: 30.sp),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      child: TextFormField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10)
                                        ],
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: _phoneController,
                                        keyboardType: TextInputType.phone,
                                        style: getMediumStyle(
                                            color: ColorManager.black,
                                            fontSize: 18.sp),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'please enter phone number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 113.h,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackbarUtil.showSuccessSnackbar(

                                          message: 'OTP Sent',
                                          duration: const Duration(milliseconds: 1000)
                                      )
                                    );
                                    Get.to(() => OTPPage(userEmail: _phoneController.text,));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.primary,
                                  padding:
                                      EdgeInsets.symmetric(vertical: 16.5.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s15.r),
                                  ),
                                ),
                                child: Text(
                                  'Continue',
                                  style: getMediumStyle(
                                      color: ColorManager.white,
                                      fontSize: 18.sp),
                                )),
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
    );
  }
}
