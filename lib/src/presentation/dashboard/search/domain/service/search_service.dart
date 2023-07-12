


import 'package:dio/dio.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/domain/model/book_model.dart';
import 'package:sajha_prakasan/src/presentation/detail/domain/model/book_model.dart';

class SearchService{

  Future<List<BookInfo>> searchBooks(String query) async {
    final dio = Dio();
    final response = await dio.post(Api.searchBook, data: {'title': query});
    try{
      if (response.statusCode == 200 && response.data["returnMsg"]["success"] == true) {
        final List<dynamic> bookDataList = response.data['details'];
        final data = bookDataList.map((e) => BookInfo.fromJson(e)).toList();
        return data;
      } else {
        // print(response.data["returnMsg"]["errors"]);
        // throw Exception(response.data["returnMsg"]["errors"]);
        final errorMessage = response.data["returnMsg"]["errors"].toString();
        return Future.error(errorMessage);
      }
    }on DioError catch(err){
      // print(err.stackTrace);
      // throw err.message!;
      final errorMessage = err.message!;
      return Future.error(errorMessage);
    }
  }
}
