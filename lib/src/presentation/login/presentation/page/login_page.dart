import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sajha_prakasan/src/data/provider/common_providert.dart';
import 'package:sajha_prakasan/src/presentation/forgot_password/forgot_password.dart';
import 'package:sajha_prakasan/src/presentation/common/snackbar.dart';
import 'package:sajha_prakasan/src/presentation/login/presentation/provider/login_provider.dart';
import 'package:sajha_prakasan/src/presentation/login/presentation/provider/user_provider.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';
import 'package:sajha_prakasan/src/core/resources/value_manager.dart';
import 'package:sajha_prakasan/src/core/resources/assets_manager.dart';



import '../../../register/signup_page.dart';

class UserLoginView extends ConsumerStatefulWidget {
  const UserLoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<UserLoginView> createState() => _UserLoginViewState();
}

class _UserLoginViewState extends ConsumerState<UserLoginView> {
  final formKey = GlobalKey<FormState>();

  /// boolean variable to check if remember me is clicked or not
  bool _isChecked = false;

  late bool _isObscure = true;
  final nameController = TextEditingController();
  final passController = TextEditingController();

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

  late Box box1;

  @override
  void initState() {
    super.initState();
    createOpenBox();
  }

  /// create a box with this function below
  void createOpenBox() async {
    box1 = await Hive.openBox('logindata');
    getData();
  }


  /// gets the stored data from the box and assigns it to the controllers
  void getData() async {
    if (box1.get('username') != null) {
      nameController.text = box1.get('username');
      _isChecked = true;
      setState(() {});
    }
    if (box1.get('password') != null) {
      passController.text = box1.get('password');
      _isChecked = true;
      setState(() {});
    }
  }




  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
        )
    );
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
                padding: EdgeInsets.symmetric(horizontal: 46.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100.h,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 700),
                      child: Image.asset(
                        ImageAssets.mainLogo,
                        width: 335.w,
                        height: 110.h,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 750),
                      child: Text(
                        'Sign In',
                        style: getBoldStyle(
                            color: ColorManager.white, fontSize: 48.sp),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 760),
                      child: Text(
                        'Fill up your credentials to sign in',
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
                margin: EdgeInsets.only(top: 380.h),
                height: 545.h,
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
                      top: 60.h,
                      right: 46.h,
                    ),
                    child: Column(
                      children: [
                        FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 200),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },
                            controller: nameController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: getMediumStyle(
                                  color: ColorManager.textGrey,
                                  fontSize: 16.sp),
                              focusColor: ColorManager.primary,
                              errorStyle: TextStyle(
                                  fontSize: 16.sp, color: ColorManager.red),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 28.w, vertical: 16.5.h),
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
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 250),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: _isObscure,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            controller: passController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: getMediumStyle(
                                  color: ColorManager.textGrey,
                                  fontSize: 16.sp),
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
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 850),
                          delay: const Duration(milliseconds: 250),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 1,
                                    child: Checkbox(
                                      value: _isChecked,
                                      onChanged: (value) {
                                        _isChecked = !_isChecked;
                                        removeLoginInfo();
                                        setState(() {});
                                      },
                                      checkColor: Colors.white,
                                      fillColor: MaterialStateProperty.resolveWith(
                                              (states) => getColor(states)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Remember me',
                                    style: getRegularStyle(
                                        color: ColorManager.textGrey,
                                        fontSize: 16.sp),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const ForgotPasswordPage(), transition: Transition.rightToLeft);
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: getMediumStyle(
                                      color: ColorManager.blue, fontSize: 15.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1200),
                          delay: const Duration(milliseconds: 300),
                          child: SizedBox(
                            width: double.infinity,
                            child: Consumer(
                              builder: (context, ref, child) {
                                final isLoad = ref.watch(loadingProvider);
                              return ElevatedButton(
                                  onPressed: isLoad ? null : () async {
                                    final scaffoldMessage = ScaffoldMessenger.of(context);
                                    if (formKey.currentState!.validate()) {
                                      ref.read(loadingProvider.notifier).toggle();
                                      login();
                                      final response = await ref.read(userLoginProvider).userLogin(
                                        email: nameController.text.trim(),
                                        password: passController.text.trim(),
                                      );
                                      ref.read(loadingProvider.notifier).toggle();
                                      if (response != 'success') {
                                        scaffoldMessage.showSnackBar(
                                          SnackbarUtil.showFailureSnackbar(
                                              message: response,
                                              duration: const Duration(milliseconds: 1400)
                                          )
                                        );
                                      } else {
                                        final box = Hive.box<String>('tokenBox');
                                        final accessToken = box.get('accessToken');
                                        await ref.read(userProvider.notifier).getUserInfo(token: accessToken!);
                                        scaffoldMessage.showSnackBar(
                                            SnackbarUtil.showSuccessSnackbar(
                                                message: 'Login Successful',
                                                duration: const Duration(milliseconds: 1200)
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
                                  child: isLoad ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Center(child: CircularProgressIndicator(color: Colors.white,),
                                      ),
                                  ) : Text(
                                    'Sign In',
                                    style: getMediumStyle(
                                        color: ColorManager.white,
                                        fontSize: 18.sp),
                                  ),
                              );
                            },)
                          ),
                        ),
                        SizedBox(
                          height: 45.h,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1200),
                          delay: const Duration(milliseconds: 320),
                          child: Center(
                              child: Text(
                            'Don\'t have an account yet?',
                            style: getMediumStyle(
                                color: ColorManager.textGrey, fontSize: 16.sp),
                          )),
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1200),
                          delay: const Duration(milliseconds: 320),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                Get.to(() => const UserSignUpView(), transition: Transition.rightToLeft);
                              },
                              child: Text(
                                'Sign Up',
                                style: getMediumStyle(
                                    color: ColorManager.blue, fontSize: 16.sp),
                              ),
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
  /// adds the user info into (box) the local database (Hive)
  void login() {
    if (_isChecked) {
      box1.put('username', nameController.value.text);
      box1.put('password', passController.value.text);
    }
  }

  /// clears the box or removes the stored credentials.
  void removeLoginInfo(){
    if(!_isChecked){
      box1.clear();
    }
  }

}
