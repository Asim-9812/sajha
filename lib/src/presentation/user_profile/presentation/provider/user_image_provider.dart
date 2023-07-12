
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sajha_prakasan/src/presentation/user_profile/data/provider/image_provider.dart';



final imageProvider = StateNotifierProvider.autoDispose<UserImageProvider, XFile?>((ref) => UserImageProvider(null));

