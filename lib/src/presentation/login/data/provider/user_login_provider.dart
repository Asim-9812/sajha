import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class LoginProvider{
  final dio = Dio();

  Future<String> userLogin({required String email, required String password}) async{
    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      try{
        final response = await dio.post(Api.userLogin, data: {
          "email": email,
          "password": password,
        });
        if(response.statusCode == 200 && response.data["success"] == true){
          final token = response.data["payload"];
          Box tokenBox = Hive.box<String>('tokenBox');
          tokenBox.put('accessToken', token);
          return 'success';
        }else{
          return 'Invalid Username or Password';
        }
      } on DioError catch(err){
        return err.message.toString();
      }
    }else{
      return 'No internet connection';
    }

  }
}