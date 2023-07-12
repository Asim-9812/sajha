import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/data/provider/common_providert.dart';
import 'package:sajha_prakasan/src/presentation/common/app_bar.dart';
import 'package:sajha_prakasan/src/presentation/common/snackbar.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/presentation/main_page.dart';
import 'package:sajha_prakasan/src/presentation/login/domain/model/user.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';

import 'package:sajha_prakasan/src/presentation/user_profile/presentation/provider/user_image_provider.dart';

import 'package:sajha_prakasan/src/presentation/user_profile/presentation/provider/user_update.dart';




enum Gender{
  male,
  female,
  other,
}

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {


  final form = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final contactController = TextEditingController();

  final userBox = Hive.box<User>('session').values.toList();


  String? _selectedGender = "";


  @override
  void initState() {
    super.initState();
    final currentUser = userBox[0];
    _selectedGender = currentUser.gender;
    firstNameController.text = currentUser.firstName;
    lastNameController.text = currentUser.lastName;
    addressController.text = currentUser.address!;
    contactController.text = currentUser.contact!;
    contactController.addListener(() {
      setState(() {});
    });
    addressController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final image = ref.watch(imageProvider);
    final isLoad = ref.watch(loadingProvider);
    final currentUser = userBox[0];

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(titleText: 'Edit Profile', hasBoxShadow: true, hasArrow: true),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30.h,),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 70.r,
                            backgroundColor: ColorManager.brightGreen,
                            child: ClipOval(
                              child: showImage(currentUser, image),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: 300.h,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: EdgeInsets.all(30.w),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 20.h,),
                                              OutlinedButton(
                                                  onPressed: (){
                                                    ref.read(imageProvider.notifier).pickImage(imgSource: ImageSource.gallery);
                                                    Navigator.pop(context);
                                                  },
                                                style: OutlinedButton.styleFrom(
                                                  minimumSize: Size(double.infinity, 54.h)
                                                ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.image, color: ColorManager.iconGrey, size: 30.h,),
                                                      SizedBox(width: 20.w,),
                                                      Text(
                                                        'Browse Gallery',
                                                        style: getMediumStyle(color: Colors.black87, fontSize: 18.sp),
                                                      )
                                                    ],
                                                  ),
                                              ),
                                              // SizedBox(height: 20.h,),
                                              // Text('OR', style: getMediumStyle(color: Colors.black87, fontSize: 18.sp),),
                                              // SizedBox(height: 10.h,),
                                              // OutlinedButton(
                                              //   onPressed: (){
                                              //     // ref.read(imageProvider.notifier).pickImage(imgSource: ImageSource.camera);
                                              //     // Navigator.pop(context);
                                              //   },
                                              //   style: OutlinedButton.styleFrom(
                                              //       minimumSize: Size(double.infinity, 54.h)
                                              //   ),
                                              //   child: Row(
                                              //     mainAxisAlignment: MainAxisAlignment.center,
                                              //     children: [
                                              //       Icon(Icons.camera_alt_sharp, color: ColorManager.iconGrey, size: 30.h,),
                                              //       SizedBox(width: 10.w,),
                                              //       Text(
                                              //         'Use Camera',
                                              //         style: getMediumStyle(color: Colors.black87, fontSize: 18.sp),
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        )
                                      );
                                    },
                                );
                              },
                              child: Container(
                                height: 36.h,
                                width: 36.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.r),
                                    border: Border.all(
                                        color: Colors.white,
                                        width: 2.w
                                    )
                                ),
                                child: Badge(
                                  label: Icon(Icons.edit_outlined, color: Colors.white, size: 20.h,),
                                  backgroundColor: Colors.blue,
                                  largeSize: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Form(
                          key: form,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      enabled: false,
                                      controller: firstNameController,
                                      validator: (val){
                                        if(val!.isEmpty){
                                          return 'please provide first name';
                                        }else if(val.length > 55){
                                          return 'maximum character is 55';
                                        }
                                        return null;
                                      },

                                      decoration: InputDecoration(
                                        labelText: 'Full Name',
                                        labelStyle: getMediumStyle(color: ColorManager.textGrey, fontSize: 15.sp),
                                        errorStyle: TextStyle(
                                            fontSize: 16.sp, color: ColorManager.red),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorManager.red,
                                            width: 1.5,
                                          ),
                                          borderRadius: BorderRadius.circular(15.r),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorManager.red,
                                            width: 1.5,
                                          ),
                                          borderRadius: BorderRadius.circular(15.r),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorManager.primary,
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20.w,),
                                  Expanded(
                                    child: TextFormField(
                                      controller: lastNameController,
                                      validator: (val){
                                        if(val!.isEmpty){
                                          return 'please provide first name';
                                        }else if(val.length > 55){
                                          return 'maximum character is 55';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        enabled: false,
                                        labelText: 'Last Name',
                                        labelStyle: getMediumStyle(color: ColorManager.textGrey, fontSize: 15.sp),
                                        errorStyle: TextStyle(
                                            fontSize: 16.sp, color: ColorManager.red),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorManager.red,
                                            width: 1.5,
                                          ),
                                          borderRadius: BorderRadius.circular(15.r),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorManager.red,
                                            width: 1.5,
                                          ),
                                          borderRadius: BorderRadius.circular(15.r),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorManager.primary,
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h,),
                              Text('Gender', style: getSemiBoldStyle(color: ColorManager.textGrey, fontSize: 14.sp),),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  Expanded(
                                    child: RadioListTile<String>(
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text('Male'),
                                      activeColor: ColorManager.primary,
                                      value: 'male',
                                      groupValue: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value;
                                        });
                                      },
                                      toggleable: true,
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile<String>(
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text('Female'),
                                      activeColor: ColorManager.primary,
                                      value: 'female',
                                      groupValue: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value;
                                        });
                                      },
                                      toggleable: true,
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile<String>(
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text('Others'),
                                      activeColor: ColorManager.primary,
                                      value: 'others',
                                      groupValue: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value;
                                        });
                                      },
                                      toggleable: true,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              TextFormField(
                                controller: contactController,
                                validator: (val){
                                  if(val!.isEmpty){
                                    return 'please enter contact';
                                  }else if(val.length > 55){
                                    return 'maximum character is 55';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Contact',
                                  labelStyle: getMediumStyle(color: ColorManager.textGrey, fontSize: 18.sp),
                                  errorStyle: TextStyle(
                                      fontSize: 16.sp, color: ColorManager.red),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.red,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.red,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.primary,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              TextFormField(
                                controller: addressController,
                                validator: (val){
                                  if(val!.isEmpty){
                                    return 'please enter address';
                                  }else if(val.length > 55){
                                    return 'maximum character is 55';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Address',
                                  labelStyle: getMediumStyle(color: ColorManager.textGrey, fontSize: 18.sp),
                                  errorStyle: TextStyle(
                                      fontSize: 16.sp, color: ColorManager.red),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.red,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.red,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.primary,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 80.h,),
                              ElevatedButton(
                                onPressed: isLoad ? null : () async {
                                  if (form.currentState!.validate()) {
                                    final scaffoldMessage = ScaffoldMessenger.of(context);
                                    ref.read(loadingProvider.notifier).toggle();
                                    final box = Hive.box<String>('tokenBox');
                                    final accessToken = box.get('accessToken');
                                    if(image == null){
                                      final response = await ref.read(userUpdateProvider).updateUserProfile(
                                        firstName: firstNameController.text.trim(),
                                        userId: currentUser.userID,
                                        token: accessToken!,
                                        email: currentUser.email,
                                        gender: _selectedGender == null ? "" : _selectedGender!.trim(),
                                        address: addressController.text.trim(),
                                        contact: contactController.text.trim(),
                                      );

                                      if(response.success){
                                        scaffoldMessage.showSnackBar(
                                          SnackbarUtil.showSuccessSnackbar(
                                            message: response.msg!,
                                            duration: const Duration(milliseconds: 1200),
                                          ),
                                        );
                                        Get.to(() => const MainView());
                                      }else{
                                        scaffoldMessage.showSnackBar(
                                          SnackbarUtil.showFailureSnackbar(
                                            message: response.errors!,
                                            duration: const Duration(milliseconds: 1200),
                                          ),
                                        );
                                      }
                                      ref.read(loadingProvider.notifier).toggle();
                                    }else{
                                      final response = await ref.read(userUpdateProvider).updateUserProfile(
                                        userId: currentUser.userID,
                                        token: accessToken!,
                                        firstName: firstNameController.text.trim(),
                                        email: currentUser.email,
                                          gender: _selectedGender == null ? "" : _selectedGender!.trim(),
                                        address: addressController.text.trim(),
                                        contact: contactController.text.trim(),
                                        profileImage: image,
                                      );
                                      if(response.success == true){
                                        scaffoldMessage.showSnackBar(
                                          SnackbarUtil.showSuccessSnackbar(
                                            message: response.msg!,
                                            duration: const Duration(milliseconds: 1200),
                                          ),
                                        );
                                        Get.to(() => const MainView());
                                      }else{
                                        scaffoldMessage.showSnackBar(
                                          SnackbarUtil.showFailureSnackbar(
                                            message: response.errors!,
                                            duration: const Duration(milliseconds: 1200),
                                          ),
                                        );
                                      }
                                      ref.read(loadingProvider.notifier).toggle();
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.primary,
                                  minimumSize: Size(double.infinity, 50.h),
                                  padding:
                                  EdgeInsets.symmetric(vertical: 16.5.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(15.r),
                                  ),
                                ),
                                child: isLoad ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(child: CircularProgressIndicator(color: Colors.white,),
                                  ),
                                ) : Text(
                                  'Update',
                                  style: getMediumStyle(
                                      color: ColorManager.white,
                                      fontSize: 18.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
    contactController.dispose();
  }



}


 showImage(User currentUser, XFile? image){
  final profilePicUrl = '${Api.baseUrl}${currentUser.profileUrl!}';

  if(image == null){
    if(currentUser.profileUrl!.isEmpty){
      return Text('${currentUser.firstName[0]}${currentUser.lastName[0]}', style: getMediumStyle(color: Colors.white, fontSize: 40.sp),);
    }else{
      return Image.network(profilePicUrl, height: 140.h, width: 140.h, fit: BoxFit.fill,);
    }
  }else{
    return Image.file(File(image.path), height: 140.h, width: 140.h, fit: BoxFit.fill,);
  }
  
  

   
 }