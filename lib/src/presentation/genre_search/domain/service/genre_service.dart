
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/domain/models/user_return.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/domain/model/book_model.dart';

class GenreService{


  static Future<Either<String, List<BookInfo>>> searchByGenre({required int collectionId, required String genre}) async{
    final dio = Dio();

   try{
     final response = await dio.post(Api.baseUrl, data: {
       "collectiontype": collectionId,
       "genretitle": genre,
     });

     if(response.statusCode == 200 && response.data["returnMsg"]["success"] == true){
       final data = (response.data["details"] as List).map((e) => BookInfo.fromJson(e)).toList();
       return right(data);
     }else{
       final result = UserReturn.fromJson(response.data["returnMsg"]);
       return left(result.errors!);
     }
   }on DioError catch(err){
     return left(err.message!);
   }


  }



}