import 'package:dio/dio.dart';
import 'package:sajha_prakasan/src/core/api.dart';


class AuthService{

  static final dio = Dio();


  static Future<Response> userLogin({required String username, required String password}) async{
    try{
      final response = await dio.post(
        Api.userLogin,
        data: {
          "email": username,
          "password": password,
        },
      );
      return response;
    }on DioError catch(err){
      throw err.message.toString();
    }
  }



  static Future<Response> userSignUp({required String firstName, required String lastName, required String email}) async{
    try{
      final response = await dio.post(
        Api.userSignUp,
        data: {
          "fName": firstName,
          "lName": lastName,
          "email": email,
        },
      );
      return response;
    }on DioError catch(err){
      throw err.message.toString();
    }
  }

  static Future<Response> verifyOTP({required String otp}) async{
    try{
      final response = await dio.post(
          Api.verifyOTP,
          data: {
            "otp": otp,
          }
      );
      return response;
    }on DioError catch(err){
      throw err.message.toString();
    }
  }

  static Future<Response> forgetPasswordVerifyOTP({required String otp}) async{
    try{
      final response = await dio.post(
          Api.forgetPasswordVerifyOTP,
          data: {
            "otp": otp,
          }
      );
      return response;
    }on DioError catch(err){
      throw err.message.toString();
    }
  }

  static Future<Response> resendOTP({required String email}) async{
    try{
      final response = await dio.post(
          "${Api.resendOTP}/$email",
          queryParameters: {
            "email": email
          },
      );
      return response;
    }on DioError catch(err){
      throw err.message.toString();
    }
  }


  static Future<Response> setPassword({required userID, required String password, required String confirmPassword}) async{
    try{
      final response = await dio.post(
        "${Api.setPassword}/$userID",
        queryParameters: {
          "userid": userID,
        },
        data: {
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );
      return response;
    }on DioError catch(err){
      throw err.message.toString();
    }
  }


  static Future<Response> forgetPassword({required String email}) async{
    try{
      final response = await dio.post(
        "${Api.forgetPassword}/$email",
        queryParameters: {
          "email": email
        },
      );
      return response;
    }on DioError catch(err){
      throw err.message.toString();
    }
  }

  static Future<Response> resetPassword({required userID, required String password, required String confirmPassword}) async{
    try{
      final response = await dio.post(
        "${Api.resetPassword}/$userID",
        queryParameters: {
          "userid": userID,
        },
        data: {
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );
      return response;
    }on DioError catch(err){
      throw err.message.toString();
    }
  }

}
