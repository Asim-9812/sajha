



import 'package:sajha_prakasan/src/presentation/user_profile/domain/service/change_password_service.dart';

class ChangePasswordProvider{

  Future<String> changePass({required String token, required String oldPass, required String newPass, required String confirmPass})async{

    final response = await PasswordChangeService.changePassword(token: token, oldPassword: oldPass, newPassword: newPass, confirmPassword: confirmPass);

    if(response.success){
      return 'success';
    }else{
      return response.errors!;
    }
  }

}

