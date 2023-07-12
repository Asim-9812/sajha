



import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/domain/model/book_model.dart';
import 'package:sajha_prakasan/src/presentation/detail/domain/model/book_model.dart';


final listProvider = Provider<List<BookInfo>>((ref) => bookList);
List<BookInfo> bookList = [];

class BookProvider{
  Future<List<BookInfo>> getAllBooksInfo() async {
    final dio = Dio();
    try{
      final response = await dio.post(Api.bookInfo);

      if(response.statusCode == 200 && response.data["returnMsg"]["success"] == true){
        final List<dynamic> bookDataList = response.data['details'];
        final data = bookDataList.map((e) => BookInfo.fromJson(e)).toList();
        for(var e in bookDataList){
          bookList.add(BookInfo.fromJson(e));
        }
        return data;
      } else {
        return [];
      }
    } on DioError catch (err){
      throw err.message!;
    }
  }

  Future<BookDetails> fetchBookDetails(int bookId) async {
    final dio = Dio();
    try{
      final response = await dio.post(
        "${Api.bookDetail}/$bookId",
        queryParameters: {
          "id": bookId,
        },
      );

      if (response.statusCode == 200 && response.data["returnMsg"]["success"] == true) {
        final data = response.data["details"];
        final bookDetails = BookDetails.fromJson(data);
        return bookDetails;
      } else {
        throw 'Failed to fetch book details';
      }
    }on DioError catch(err){
      throw err.message.toString();
    }
  }

}