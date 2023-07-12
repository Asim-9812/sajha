


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';




class UserImageProvider extends StateNotifier<XFile?>{
  UserImageProvider(super.state);

  void pickImage({required ImageSource imgSource}) async{
    final ImagePicker picker = ImagePicker();
    state = await picker.pickImage(source: imgSource);
  }
}