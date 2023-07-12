
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sajha_prakasan/src/presentation/auth/data/provider/auth_provider.dart';

import 'package:sajha_prakasan/src/presentation/common/snackbar.dart';
import 'package:sajha_prakasan/src/presentation/forgot_password/verify_otp.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';


import '../../data/provider/common_providert.dart';


class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: getSemiBoldStyle(color: Colors.black, fontSize: 24.sp),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 28,)
        ),
      ),
     body: Padding(
       padding: const EdgeInsets.all(20),
       child: Column(
         children: [
           SizedBox(height: 80.h,),
           Align(
               alignment: Alignment.center,
               child: Text('Forgot your password?', style: getBoldStyle(color: Colors.black, fontSize: 20),
               ),
           ),
           SizedBox(height: 20.h,),
           Text('Enter your registered email below to receive password reset instruction', style: getSemiBoldStyle(color: ColorManager.textGrey, fontSize: 18.sp),textAlign: TextAlign.center),
           SizedBox(height: 50.h,),
           Form(
             key: formKey,
             child: Column(
               children: [
                 TextFormField(
                   autovalidateMode:
                   AutovalidateMode.onUserInteraction,
                   validator: (value) {
                     if (value!.isEmpty) {
                       return 'Email is required';
                     }
                     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                       return 'Please enter a valid email address';
                     }
                     return null;
                   },
                   textInputAction: TextInputAction.done,
                   controller: emailController,
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
                         horizontal: 28.w, vertical: 18.h),
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
                 SizedBox(height: 50.h,),
                 Consumer(
                   builder: (context, ref, child) {
                     final isLoad = ref.watch(loadingProvider);
                     return SizedBox(
                       width: double.infinity,
                       child: ElevatedButton(
                           onPressed: isLoad ? null : () async {
                             final scaffoldMessege = ScaffoldMessenger.of(context);
                             if (formKey.currentState!.validate()) {
                               ref.read(loadingProvider.notifier).toggle();
                               final response =  await AuthProvider().forgetPassword(
                                 email: emailController.text.trim(),
                               );
                               if(response.success == false){
                                 scaffoldMessege.showSnackBar(
                                   SnackbarUtil.showFailureSnackbar(
                                       message: response.errors.toString(),
                                       duration: const Duration(seconds: 2)
                                   ),
                                 );
                                 ref.read(loadingProvider.notifier).toggle();
                               }else{
                                 scaffoldMessege.showSnackBar(
                                     SnackbarUtil.showSuccessSnackbar(
                                         message: response.msg.toString(),
                                         duration: const Duration(milliseconds: 1400)
                                     )
                                 );
                                 Get.to(() => VerifyOTPPage(userEmail: emailController.text.trim()),transition: Transition.rightToLeft);
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
                               BorderRadius.circular(15.r),
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
                     );
                   },
                 ),
               ],
             ),
           )
         ],
       ),
     )
    );
  }
}
