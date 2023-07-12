
import 'package:sajha_prakasan/src/presentation/auth/domain/auth_service.dart';
import 'package:sajha_prakasan/src/domain/models/user_return.dart';



class AuthProvider{

  Future<UserReturn> userSignUp({required String fName, required String lName, required String email}) async{
    final response = await AuthService.userSignUp(firstName: fName, lastName: lName, email: email);
    final newUser = UserReturn.fromJson(response.data);
    return newUser;
  }

  Future<UserReturn> otpVerify({required String otp,}) async{
    final response = await AuthService.verifyOTP(otp: otp);
    final newUser = UserReturn.fromJson(response.data);
    return newUser;
  }

  Future<UserReturn> resendOTP({required String email,}) async{
    final response = await AuthService.resendOTP(email: email);
    final newUser = UserReturn.fromJson(response.data);
    return newUser;
  }


  Future<UserReturn> setPassword({required String userID, required String password, required String confirmPassword}) async{
    final response = await AuthService.setPassword(userID: userID, password: password, confirmPassword: confirmPassword);
    final newUser = UserReturn.fromJson(response.data);
    return newUser;
  }

  Future<UserReturn> forgetPassword({required String email,}) async{
    final response = await AuthService.forgetPassword(email: email);
    final newUser = UserReturn.fromJson(response.data);
    return newUser;
  }


  Future<UserReturn> forgetPasswordVerifyOTP({required String otp,}) async{
    final response = await AuthService.forgetPasswordVerifyOTP(otp: otp);
    final newUser = UserReturn.fromJson(response.data);
    return newUser;
  }

  Future<UserReturn> resetPassword({required String userID, required String password, required String confirmPassword}) async{
    final response = await AuthService.resetPassword(userID: userID, password: password, confirmPassword: confirmPassword);
    final newUser = UserReturn.fromJson(response.data);
    return newUser;
  }

}

