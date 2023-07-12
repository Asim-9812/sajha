



import 'package:dio/dio.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/domain/models/user_return.dart';

class CommentService{



  static Future<UserReturn> postComment({required String token, required int bookId, required int userId, required String comment})async{
    final dio = Dio();

    try{
     final response = await dio.post(
       Api.addComment,
       data: {
         "bookID": bookId,
         "appUserID": userId,
         "comments": comment,
       },
       options: Options(
           headers: {
             "Authorization": 'Bearer $token',
             "Content-Type": 'application/json',
           }
       ),
     );
     final result = UserReturn.fromJson(response.data);
     return result;
    }on DioError catch(err){
      throw err.message!;
    }
  }
  
}