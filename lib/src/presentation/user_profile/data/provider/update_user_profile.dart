


import 'package:image_picker/image_picker.dart';
import 'package:sajha_prakasan/src/domain/models/user_return.dart';
import 'package:sajha_prakasan/src/presentation/user_profile/domain/service/user_profile_service.dart';

class UpdateUserProfile {

  Future<UserReturn> updateUserProfile({required int userId ,required String token, required String firstName, required String email, String? address, String? gender, String? contact, XFile? profileImage,})async{

    final response = await UserProfileService.updateUserProfile(token: token, firstName: firstName, email: email, address: address, profileImage: profileImage, gender: gender, contact: contact, userId: userId);

    if(response.success == true){
      return response;
    }else{
      return response;
    }
  }

}