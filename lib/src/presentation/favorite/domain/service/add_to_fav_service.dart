


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/domain/models/user_return.dart';
import 'package:sajha_prakasan/src/presentation/favorite/domain/model/favorite_book_model.dart';

class FavoriteService{

  static Future<List<FavoriteBook>> getFavBooks(int userID) async{
    final dio = Dio();

    try{
      final response = await dio.post('${Api.getFavoriteBook}/$userID',
        queryParameters: {
          "UserID": userID,
        },
      );

      if(response.statusCode == 200 && response.data["returnMsg"]["success"] == true){
        final List<dynamic> myBooks = response.data["details"];
        final data = myBooks.map((e) => FavoriteBook.fromJson(e)).toList();
        return data;
      }else{
        return [];
      }
    }on DioError catch(err){
      throw err.message!;
    }

  }

  static Future<UserReturn> addToFavorite({required int bookId, required int userId}) async{
    final dio = Dio();

    dio.options.connectTimeout = const Duration(milliseconds: 20000); /// 20 seconds
    dio.options.receiveTimeout = const Duration(milliseconds: 20000); /// 20 seconds

    try{
      final response = await dio.post(
        Api.addFavoriteBook,
        data: {
          "bookID": bookId,
          "appUserID": userId,
        }
      );

      final result = UserReturn.fromJson(response.data);
      return result;

    }on DioError catch(err){
      throw err.message!;
    }


  }

  static Future<UserReturn> removeBookFromFavorite({required int bookId, required int userID}) async{

    final dio = Dio();
    try{
      final response = await dio.post(
        Api.removeFavoriteBook,
        data: {
          "appUserID": userID,
          "bookID": bookId,
        },
      );
      final result = UserReturn.fromJson(response.data);
      return result;
      
    }on DioError catch(err){
      throw err.message!;
    }
  }

}