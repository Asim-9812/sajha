import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:sajha_prakasan/src/presentation/cart/data/provider/cart_provider.dart';
import 'package:sajha_prakasan/src/presentation/common/app_bar.dart';
import 'package:sajha_prakasan/src/presentation/common/dashed_separator.dart';
import 'package:sajha_prakasan/src/presentation/common/snackbar.dart';

import 'package:sajha_prakasan/src/presentation/dashboard/presentation/main_page.dart';
import 'package:sajha_prakasan/src/presentation/payment/data/provider/check_out_provider.dart';
import 'package:sajha_prakasan/src/presentation/payment/domain/model/checkout_book_model.dart';
import 'package:sajha_prakasan/src/presentation/common/date_formatter.dart';
import '../../login/domain/model/user.dart';
import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';


class NewPaymentPage extends ConsumerStatefulWidget {


  const NewPaymentPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NewPaymentPage> createState() => _NewPaymentPageState();
}

class _NewPaymentPageState extends ConsumerState<NewPaymentPage> {
  final userBox = Hive.box<User>('session').values.toList();

  @override
  Widget build(BuildContext context) {
    final currentUser = userBox[0];
    final cartData = ref.watch(cartProvider);
    final totalPrice = ref.watch(cartProvider.notifier).getTotal;


    List<CheckoutBook> bookList = <CheckoutBook>[];
    for (var e in cartData) {
      bookList.add(CheckoutBook(appUserID: currentUser.userID, bookEditionId: e.bookEditionId));
    }

    return Scaffold(
      backgroundColor: ColorManager.scaffolColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(titleText: 'Invoice', hasBoxShadow: true, hasArrow: true,),
            SizedBox(
              height: 25.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bill To', style: getMediumStyle(color: Colors.black, fontSize: 16.sp),),
                      SizedBox(height: 2.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${currentUser.firstName} ${currentUser.lastName}', style: getMediumStyle(color: Colors.black, fontSize: 18.sp),),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: 'Invoice Date:  ', style: getRegularStyle(color: ColorManager.blue, fontSize: 16.sp)),
                                TextSpan(text: dateFormatter(), style: getRegularStyle(color: ColorManager.black, fontSize: 14.sp)),
                              ]
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30.h,),
                      Text('Order Summary',
                        style: TextStyle(
                            color: ColorManager.primary,
                            fontFamily: 'Lato',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      SizedBox(
                        height: 320.h,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cartData.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 50.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(cartData[index].bookName, style: getRegularStyle(color: Colors.black, fontSize: 16.sp),),
                                  Text('Rs. ${cartData[index].price}', style: getRegularStyle(color: Colors.black, fontSize: 16.sp),),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 1.2,
                              thickness: 1,
                              color: Colors.black.withOpacity(0.10),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      MySeparator(color: Colors.black.withOpacity(0.8),),
                      SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TOTAL', style: getBoldStyle(color: Colors.black, fontSize: 18.sp),),
                          RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: 'NPR. ', style: getBoldStyle(color: Colors.red, fontSize: 18.sp)),
                                  TextSpan(text: '$totalPrice', style: getBoldStyle(color: Colors.red, fontSize: 18.sp)),
                                ]
                              )
                          )
                        ],
                      ),
                      SizedBox(height: 30.h,),
                      SizedBox(
                        height: 52.h,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              final scaffoldMessage = ScaffoldMessenger.of(context);
                              final result = await CheckOutProvider().checkOut(bookList);
                              if(result == "success"){
                                ref.read(cartProvider.notifier).clear();
                              }else{
                                scaffoldMessage.showSnackBar(
                                  SnackbarUtil.showFailureSnackbar(message: result, duration: const Duration(milliseconds: 1400))
                                );
                              }
                              await Future.delayed(const Duration(seconds: 0), () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    content: SizedBox(
                                      height: 400.h,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 40.h,),
                                          Text('Payment Successful!!', style: getBoldStyle(color: ColorManager.primary, fontSize: 18.sp),),
                                          SizedBox(height: 43.h,),
                                          Text('Thank you for your subscription. You will receive an email receipt shortly', style: getBoldStyle(color: ColorManager.textGrey, fontSize: 16.sp), textAlign: TextAlign.center),
                                          SizedBox(height: 40.h,),
                                          Image.asset('assets/emojis/emoji_success.png'),
                                          SizedBox(height: 62.h,),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context, true);
                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainView(),));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: ColorManager.primary,
                                                  padding: EdgeInsets.symmetric(vertical: 16.5.h),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                ),
                                                child: Text('Finish', style: getMediumStyle(color: ColorManager.white, fontSize: 18.sp),)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                  ),
                                );
                              },);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                              // padding: EdgeInsets.symmetric(vertical: 16.5.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                            child: Text('Pay', style: getMediumStyle(color: ColorManager.white, fontSize: 18.sp),)
                        ),
                      ),
                      SizedBox(height: 35.h,),
                      Row(
                        children: [
                          const Expanded(child: Divider(thickness: 1.5,)),
                          SizedBox(width: 6.w,),
                          Text('OR', style: getSemiBoldStyle(color: ColorManager.black, fontSize: 14.sp),),
                          SizedBox(width: 6.w,),
                          const Expanded(child: Divider(thickness: 1.5,)),
                        ],
                      ),
                      SizedBox(height: 15.h,),
                      Center(
                        child: Text('Continue with:', style: getSemiBoldStyle(color: ColorManager.blackOpacity80, fontSize: 14.sp),
                        ),
                      ),
                      SizedBox(height: 18.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const[
                            CustomOutlineButton(gateWayName: 'E-Sewa', imageUrl: 'assets/icons/esewa_logo.png',),
                            CustomOutlineButton(gateWayName: 'Khalti', imageUrl: 'assets/icons/khalti_logo.png',),
                          ],
                        ),
                      ),
                      // SizedBox(height: 10.h,),
                    ],
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



// custom button for the payment gateway.
class CustomOutlineButton extends StatelessWidget {
  final String gateWayName;
  final String imageUrl;
  const CustomOutlineButton({
    Key? key, required this.gateWayName, required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: (){
        if(gateWayName == 'E-Sewa'){
          print('esewa gateway');
        }else{
          print('khalti gateway');
        }
      },
      style: OutlinedButton.styleFrom(
        minimumSize: Size(160.w, 50.h),
          padding: const EdgeInsets.all(13),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r)
          )
      ),
      child: Row(
        children: [
          Image.asset(imageUrl, height: 30.h, width: 30.w,),
          Text(gateWayName, style: getRegularStyle(color: ColorManager.black, fontSize: 20.sp),)
        ],
      ),
    );
  }
}


// the following class extends the TextInputFormatter class and is used to give spacing between every 4 digits as in visa card.
class CreditCardInputFormat extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset == 0){
      return newValue;
    }

    String enteredData = newValue.text;   // get data enter by used in textField
    StringBuffer buffer = StringBuffer();

    for(int i = 0;i <enteredData.length;i++){
      // add each character into String buffer
      buffer.write(enteredData[i]);
      int index = i + 1;
      if(index % 4 == 0 && enteredData.length != index){
        // add space after 4th digit
        buffer.write("  ");
      }
    }
    return  TextEditingValue(
        text: buffer.toString(),   // final generated credit card number
        selection: TextSelection.collapsed(offset: buffer.toString().length) // keep the cursor at end
    );
  }

}


//just as above this class is used to give the "/" sign between the digit just like in expiry date of a card eg. "09/12"
class CardExpirationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'/'));
      if (nonZeroIndex % 2 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += '/';
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}