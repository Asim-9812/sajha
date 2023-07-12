import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/presentation/payment/domain/model/checkout_book_model.dart';



class CheckOutService{

  static Future<String> bookCheckout(List<CheckoutBook> bookList) async{
    final dio = Dio();

    try{
      final checkData = jsonEncode(bookList.map((book) => book.toJson()).toList());

      final response = await dio.post(Api.bookCheckout, data: checkData);

      if(response.statusCode == 200 && response.data["success"] == true){
        return "success";
      }else{
        return response.data["errors"];
      }

    }on DioError catch(err){
      throw err.message!;
    }

  }
}