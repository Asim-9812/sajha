import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sajha_prakasan/src/presentation/auth/data/provider/auth_provider.dart';
import 'package:sajha_prakasan/src/presentation/common/snackbar.dart';
import 'package:sajha_prakasan/src/presentation/login/presentation/page/status_page.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';
import 'package:sajha_prakasan/src/core/resources/value_manager.dart';



class PasswordPage extends StatefulWidget {
  final String userID;
  const PasswordPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordPage> {
  final formKey = GlobalKey<FormState>();

  late bool _isObscure = true;
  late bool _isObscureRepeatPass = true;

  final _passController = TextEditingController();
  final _repeatPassController = TextEditingController();

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
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        )
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
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
                      Text(
                        'Set Up Password',
                        style: getBoldStyle(
                            color: ColorManager.white, fontSize: 48.sp),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Enter a password for your account',
                        style: getMediumStyle(
                            color: ColorManager.white, fontSize: 14.sp),
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: EdgeInsets.only(top: 350.h),
                  height: 600.h,
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
                            height: 20.h,
                          ),
                          TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            obscureText: _isObscure,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 6) {
                                return 'Enter minimum 6 characters';
                              }
                              if (value.contains(' ')) {
                                return 'Do not enter spaces';
                              }
                              if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
                                return 'Enter at least one uppercase letter';
                              }
                              if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
                                return 'Enter at least one lowercase letter';
                              }
                              if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
                                return 'Enter at least one Digit';
                              }
                              if (!RegExp(r'^(?=.*?[!@#&*~])').hasMatch(value)) {
                                return 'Enter at least one special character';
                              }
                              return null;
                            },
                            controller: _passController,
                            decoration: InputDecoration(
                              labelText: 'Password',
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
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility_rounded,
                                    color: _isObscure
                                        ? ColorManager.textGrey
                                        : ColorManager.primary,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 13.h,
                          ),
                          TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            obscureText: _isObscureRepeatPass,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }else if(_passController.text.trim() != _repeatPassController.text.trim()){
                                return 'Password does not match';
                              }
                              return null;
                            },
                            controller: _repeatPassController,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
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
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscureRepeatPass = !_isObscureRepeatPass;
                                    });
                                  },
                                  icon: Icon(
                                    _isObscureRepeatPass
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility_rounded,
                                    color: _isObscureRepeatPass
                                        ? ColorManager.textGrey
                                        : ColorManager.primary,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  final scaffoldMessage = ScaffoldMessenger.of(context);
                                  if (formKey.currentState!.validate()) {
                                    final response = await AuthProvider().setPassword(
                                        userID: widget.userID,
                                        password: _passController.text.trim(),
                                        confirmPassword: _repeatPassController.text.trim(),
                                    );
                                    if(response.success == true){
                                      scaffoldMessage.showSnackBar(
                                          SnackbarUtil.showSuccessSnackbar(
                                            message: '${response.msg}',
                                            duration: const Duration(milliseconds: 1200),
                                          )
                                      );
                                      Get.to(() => const StatusPage());
                                    }else{
                                      scaffoldMessage.showSnackBar(
                                          SnackbarUtil.showFailureSnackbar(
                                            message: '${{response.errors}}',
                                            duration: const Duration(milliseconds: 1200),
                                          )
                                      );
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
                                ),
                                child: Text(
                                  'Done',
                                  style: getMediumStyle(
                                      color: ColorManager.white,
                                      fontSize: 18.sp),
                                )),
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
      ),
    );
  }
}
