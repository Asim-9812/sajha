
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/domain/models/user_return.dart';

class UserProfileService{

  static Future<UserReturn> updateUserProfile({required int userId, required String firstName, required String email, String? contact, String? address, String? gender, XFile? profileImage, required String token}) async{
    final dio = Dio();

    FormData userFormData = FormData.fromMap({
      'Gender': gender,
      'Address': address,
      'Contact': contact,
      'ProfilePicName': '$firstName-$userId',
      'picfile': profileImage == null ? "" : await MultipartFile.fromFile(profileImage.path),
    });

    try{
      final response = await dio.post(
          '${Api.updateUser}/$email',
          queryParameters: {
          "email": email,
          },
          options: Options(
            headers: {
              "Authorization": 'Bearer $token',
              'Content-Type': 'application/json',
            }
          ),
          data: userFormData
      );
      final result = UserReturn.fromJson(response.data["returnMsg"]);
      return result;
    }on DioError catch(err){
      throw err.message!;
    }
  }


}