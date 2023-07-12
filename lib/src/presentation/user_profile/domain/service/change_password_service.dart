
import 'package:dio/dio.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/domain/models/user_return.dart';

class PasswordChangeService{

  static Future<UserReturn> changePassword({ required String token, required String oldPassword, required String newPassword, required String confirmPassword}) async{

    final dio = Dio();

    FormData formData = FormData.fromMap({
      'currentpassword': oldPassword,
      'newpassword': newPassword,
      'confirmpassword': confirmPassword,
      });

    try{
      final response = await dio.post(
        Api.changePassword,
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
        ), 
        data: formData,
      );
      final result = UserReturn.fromJson(response.data);
      return result;
    }on DioError catch(err){
      throw err.message!;
    }

  }


}