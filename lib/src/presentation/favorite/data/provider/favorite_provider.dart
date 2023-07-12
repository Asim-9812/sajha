


import 'package:dio/dio.dart';

import 'package:hive/hive.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/presentation/favorite/domain/model/favorite_book_model.dart';
import 'package:sajha_prakasan/src/presentation/favorite/domain/service/add_to_fav_service.dart';
import 'package:sajha_prakasan/src/presentation/login/domain/model/user.dart';

final userBox = Hive.box<User>('session').values.toList();
final userId = userBox[0].userID;

class FavoriteProvider{

  Future<List<FavoriteBook>> getFavoriteBooks() async{
    final dio = Dio();

    try{
      final response = await dio.post('${Api.getFavoriteBook}/$userId',
        queryParameters: {
          "UserID": userId,
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

  Future<String> addBookToFavorite({required int bookId}) async{

    final response = await FavoriteService.addToFavorite(bookId: bookId, userId: userId);

    if(response.success == true){
      return 'success';
    }else{
      return response.errors!;
    }
}

  Future<String> removeFavBook({required int bookId}) async{
    final response = await FavoriteService.removeBookFromFavorite(bookId: bookId, userID: userId);

    if(response.success == true){
      return 'success';
    }else{
      return response.errors!;
    }
  }

}