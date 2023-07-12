

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/presentation/login/domain/model/user.dart';


class UserProvider extends StateNotifier<List<User>>{
  UserProvider(super._state);

  Future<String> getUserInfo({required String token}) async{
    final dio = Dio();

    try{
      final response = await dio.post(Api.userInfo,
          options: Options(
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              }
          ));

      if(response.statusCode == 200){
        final newUser = User.fromJson(response.data["userdetail"]);

        if(Hive.box<User>('session').isEmpty){
          Hive.box<User>('session').add(newUser);
          state = [newUser];
        }else{
          Hive.box<User>('session').putAt(0, newUser);
          state = [newUser];
        }
        return 'success';
      }else{
        return 'failed to fetch User Data';
      }

    }on DioError catch(err){
      throw err.message!;
    }
  }

  void userLogout() async{
    Hive.box<String>('tokenBox').clear();
    Hive.box<User>('session').clear();
    state = [];
  }
}