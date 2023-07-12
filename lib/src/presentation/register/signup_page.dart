import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sajha_prakasan/src/presentation/auth/data/provider/auth_provider.dart';
import 'package:sajha_prakasan/src/data/provider/common_providert.dart';
import 'package:sajha_prakasan/src/presentation/register/otp_page.dart';
import 'package:sajha_prakasan/src/presentation/common/snackbar.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';
import 'package:sajha_prakasan/src/core/resources/value_manager.dart';


class UserSignUpView extends StatefulWidget {
  const UserSignUpView({Key? key}) : super(key: key);

  @override
  State<UserSignUpView> createState() => _UserSignUpViewState();
}

class _UserSignUpViewState extends State<UserSignUpView> {
  final formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return ColorManager.primary;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 430.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorManager.primary,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 46.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 180.h,
                    ),
                    FadeInRight(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        'Sign Up',
                        style: getBoldStyle(
                            color: ColorManager.white, fontSize: 48.sp),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    FadeInRight(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        'Fill up your credentials to sign up',
                        style: getMediumStyle(
                            color: ColorManager.white, fontSize: 14.sp),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: EdgeInsets.only(top: 350.h),
                height: 575.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30.r)),
                ),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 46.h,
                      top: 46.h,
                      right: 46.h,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 13.h,
                        ),
                        FadeInRight(
                          duration: const Duration(milliseconds: 500),
                          delay: const Duration(milliseconds: 100),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'First Name is required';
                              }else if(value[0] != value[0].toUpperCase()){
                                return 'First letter should be Capital';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            controller: _firstnameController,
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle: getMediumStyle(
                                  color: ColorManager.textGrey,
                                  fontSize: 18.sp),
                              focusColor: ColorManager.primary,
                              errorStyle: TextStyle(
                                  fontSize: 16.sp, color: ColorManager.red),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 28.w, vertical: 16.5.h),
                              filled: true,
                              fillColor: ColorManager.inputGreen,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.primary,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              floatingLabelStyle:
                                  TextStyle(color: ColorManager.primaryDark),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                        FadeInRight(
                          duration: const Duration(milliseconds: 500),
                          delay: const Duration(milliseconds: 150),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Last Name is required';
                              }else if(value[0] != value[0].toUpperCase()){
                                return 'First letter should be Capital';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            controller: _lastnameController,
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: getMediumStyle(
                                  color: ColorManager.textGrey,
                                  fontSize: 18.sp),
                              focusColor: ColorManager.primary,
                              errorStyle: TextStyle(
                                  fontSize: 16.sp, color: ColorManager.red),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 28.w, vertical: 16.5.h),
                              filled: true,
                              fillColor: ColorManager.inputGreen,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.primary,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              floatingLabelStyle:
                                  TextStyle(color: ColorManager.primaryDark),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                        FadeInRight(
                          duration: const Duration(milliseconds: 500),
                          delay: const Duration(milliseconds: 200),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email is required';
                              }
                              if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: getMediumStyle(
                                  color: ColorManager.textGrey,
                                  fontSize: 18.sp),
                              focusColor: ColorManager.primary,
                              errorStyle: TextStyle(
                                  fontSize: 16.sp, color: ColorManager.red),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 28.w, vertical: 16.5.h),
                              filled: true,
                              fillColor: ColorManager.inputGreen,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.primary,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              floatingLabelStyle:
                                  TextStyle(color: ColorManager.primaryDark),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final isLoad = ref.watch(loadingProvider);
                            return FadeInRight(
                              duration: const Duration(milliseconds: 500),
                              delay: const Duration(milliseconds: 300),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: isLoad ? null : () async {
                                      final scaffoldMessege = ScaffoldMessenger.of(context);
                                      if (formKey.currentState!.validate()) {
                                        ref.read(loadingProvider.notifier).toggle();
                                        final response =  await AuthProvider().userSignUp(
                                            fName: _firstnameController.text.trim(),
                                            lName: _lastnameController.text.trim(),
                                            email: _emailController.text.trim(),
                                        );
                                        if(response.success == false){
                                         scaffoldMessege.showSnackBar(
                                              SnackbarUtil.showFailureSnackbar(
                                                  message: '${response.errors}',
                                                  duration: const Duration(seconds: 2)
                                              ),
                                          );
                                         ref.read(loadingProvider.notifier).toggle();
                                        }else{
                                          scaffoldMessege.showSnackBar(
                                            SnackbarUtil.showSuccessSnackbar(
                                                message: '${response.msg}',
                                                duration: const Duration(milliseconds: 1400)
                                            )
                                          );
                                          Get.to(() => OTPPage(userEmail: '${response.payload}'),transition: Transition.rightToLeft);
                                          ref.read(loadingProvider.notifier).toggle();
                                        }
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
                                      minimumSize: Size(double.infinity, 60.h),
                                    ),
                                    child: isLoad ? const Center(
                                        child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(color: Colors.white))) : Text(
                                      'Continue',
                                      style: getMediumStyle(
                                          color: ColorManager.white,
                                          fontSize: 18.sp),
                                    )),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        FadeInRight(
                          duration: const Duration(milliseconds: 500),
                          delay: const Duration(milliseconds: 350),
                          child: Text(
                            'Already have an account?',
                            style: getMediumStyle(
                                color: ColorManager.textGrey,
                                fontSize: 16.sp),
                          ),
                        ),
                        FadeInRight(
                          duration: const Duration(milliseconds: 500),
                          delay: const Duration(milliseconds: 350),
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'Sign In',
                              style: getMediumStyle(
                                  color: ColorManager.blue, fontSize: 18.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
