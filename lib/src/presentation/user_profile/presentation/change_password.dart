import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hive/hive.dart';
import 'package:sajha_prakasan/src/data/provider/common_providert.dart';
import 'package:sajha_prakasan/src/presentation/common/app_bar.dart';
import 'package:sajha_prakasan/src/presentation/common/snackbar.dart';

import 'package:sajha_prakasan/src/presentation/login/presentation/page/status_page.dart';
import 'package:sajha_prakasan/src/presentation/login/presentation/provider/user_provider.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';
import 'package:sajha_prakasan/src/core/resources/value_manager.dart';
import 'package:sajha_prakasan/src/presentation/user_profile/presentation/provider/change_pass_provider.dart';


class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passController = TextEditingController();
  final _pass2Controller = TextEditingController();
  final _pass3Controller = TextEditingController();


  late bool _isObscure = true;
  late bool _isObscureRepeatPass = true;

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
                  const CustomAppBar(titleText: 'Change Password', hasBoxShadow: true, hasArrow: true,),
                  SizedBox(
                    height: 114.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 46.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Enter current Password', style: getRegularStyle(color: ColorManager.black, fontSize: 16.sp),),
                          SizedBox(height: 15.h,),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter current password';
                              }
                              return null;
                            },
                            controller: _passController,
                            textInputAction: TextInputAction.next,
                            obscureText: true,
                            decoration: InputDecoration(
                             hintText: 'Password',
                              labelStyle: getMediumStyle(color: ColorManager.textGrey, fontSize: 18.sp),
                              focusColor: ColorManager.primary,
                              errorStyle: TextStyle(fontSize: 16.sp, color: ColorManager.red),
                              contentPadding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 16.5.h),
                              filled: true,
                              fillColor: ColorManager.inputGreen,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.primary,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              floatingLabelStyle: TextStyle(
                                  color: ColorManager.primaryDark
                              ),
                            ),
                          ),
                          SizedBox(height: 32.h,),
                          Text('Enter New Password', style: getRegularStyle(color: ColorManager.black, fontSize: 16.sp),),
                          SizedBox(height: 15.h,),
                          TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            obscureText: _isObscure,
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
                            //textInputAction: TextInputAction.next,
                            controller: _pass2Controller,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: getMediumStyle(
                                  color: ColorManager.textGrey,
                                  fontSize: 18.sp),
                              focusColor: ColorManager.primary,
                              errorStyle: TextStyle(
                                  fontSize: 16.sp, color: ColorManager.red),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 28.w, vertical: 16.5),
                              filled: true,
                              fillColor: ColorManager.inputGreen,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.primary,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15.r),
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
                          SizedBox(height: 20.h,),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }else if(_pass2Controller.text.trim() != _pass3Controller.text.trim()){
                                return 'Password does not match';
                              }
                              return null;
                            },
                            //textInputAction: TextInputAction.done,
                            controller: _pass3Controller,
                            obscureText: _isObscureRepeatPass,
                            decoration: InputDecoration(
                              hintText: 'Repeat Password',
                              labelStyle: getMediumStyle(color: ColorManager.textGrey, fontSize: 18.sp),
                              focusColor: ColorManager.primary,
                              errorStyle: TextStyle(fontSize: 16.sp, color: ColorManager.red),
                              contentPadding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 16.5.h),
                              filled: true,
                              fillColor: ColorManager.inputGreen,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.primary,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              floatingLabelStyle: TextStyle(
                                  color: ColorManager.primaryDark
                              ),
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
                                  ),
                              ),
                            ),
                          ),
                          SizedBox(height: 86.h,),
                          SizedBox(
                            width: double.infinity,
                            child: Consumer(
                              builder: (context, ref, child) {
                                final isLoad = ref.watch(loadingProvider);
                                final box = Hive.box<String>('tokenBox');
                                final accessToken = box.get('accessToken');
                                return ElevatedButton(
                                    onPressed: isLoad ? null : () async {
                                      final navigator = Navigator.of(context);
                                      if (_formKey.currentState!.validate()) {
                                        final scaffoldMessage = ScaffoldMessenger.of(context);
                                        ref.read(loadingProvider.notifier).toggle();
                                        final response = await ref.read(changePasswordProvider).changePass(
                                          token: accessToken!,
                                          oldPass: _passController.text.trim(),
                                          newPass: _pass2Controller.text.trim(),
                                          confirmPass: _pass3Controller.text.trim(),
                                        );
                                        ref.read(loadingProvider.notifier).toggle();
                                        if(response != 'success'){
                                          scaffoldMessage.showSnackBar(
                                            SnackbarUtil.showFailureSnackbar(
                                                message: response,
                                                duration: const Duration(milliseconds: 1200)
                                            ),
                                          );
                                        }else{
                                          ref.read(userProvider.notifier).userLogout();
                                          navigator.pushReplacement(MaterialPageRoute(builder: (context) => const StatusPage(),));
                                          scaffoldMessage.showSnackBar(
                                            SnackbarUtil.showSuccessSnackbar(
                                                message: 'Password Changed Successfully',
                                                duration: const Duration(milliseconds: 1200),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorManager.primary,
                                      padding: EdgeInsets.symmetric(vertical: 16.5.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(AppSize.s15.r),
                                      ),
                                    ),
                                    child: isLoad ? SizedBox(
                                      height: 20.h,
                                      width: 20.h,
                                      child: const Center(
                                        child: CircularProgressIndicator(color: Colors.white,),
                                      ),
                                    ) : Text('Submit', style: getMediumStyle(color: ColorManager.white, fontSize: 18.sp),)
                                );
                              },
                            )
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
