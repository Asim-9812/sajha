



import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/domain/models/user_return.dart';


class CheckBook{

  Future<Response> checkBook({required int userId, required int bookEditionId}) async{
    final dio = Dio();
    
    try{
      final response = await dio.post(Api.checkBook,
        data: {
          "appUserID": userId,
          "bookEditionID": bookEditionId
        }
      );

      return response;

    }on DioError catch(err){
      throw err.message!;
    }
  }

}