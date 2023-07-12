



import 'package:dio/dio.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/domain/models/user_return.dart';

class BookRatingService{

  static Future<UserReturn> rateBook({required String token, required int bookId, required int appUserId, required int rating}) async{
    final dio = Dio();

    try{
      final response = await dio.post(Api.submitRating,
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
            "Content-Type": 'application/json',
          }
        ),
        data: {
          "bookID": bookId,
          "appUserID": appUserId,
          "rating": rating,
        }
      );


      final result = UserReturn.fromJson(response.data);
      return result;
    }on DioError catch(err){
      throw err.message!;
    }
  }


}