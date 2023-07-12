
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/domain/model/book_model.dart';


class BookService{

  static Future<Either<String, List<BookInfo>>> getBookByCategory({required String apiPath,}) async{
    final dio = Dio();

    try{
      final response = await dio.post(apiPath);
      final data = (response.data["details"] as List).map((e) => BookInfo.fromJson(e)).toList();
      return right(data);
    }on DioError catch(err){
      return left(err.message!);
    }
  }

}