

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/presentation/book_list/domain/model/book_list_model.dart';




class BookListService{

  final box = Hive.box<String>('tokenBox');

  Future<List<BookListModel>> getSubscribedBooks(int userID) async{
    final dio = Dio();

    try{
      final accessToken = box.get('accessToken');
      final response = await dio.post('${Api.getBookList}/$userID',
        options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json',
            }
        ),
        queryParameters: {
          "UserID": userID,
        },
      );

      if(response.statusCode == 200 && response.data["returnMsg"]["success"] == true){
        final List<dynamic> myBooks = response.data["bookList"];
        final data = myBooks.map((e) => BookListModel.fromJson(e)).toList();
        return data;
      }else{
        return [];
      }
    }on DioError catch(err){
      throw err.message!;
    }

  }
}