


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajha_prakasan/main.dart';
import 'package:sajha_prakasan/src/presentation/login/data/provider/user_provider.dart';
import 'package:sajha_prakasan/src/presentation/login/domain/model/user.dart';

final userProvider = StateNotifierProvider<UserProvider, List<User>>((ref) => UserProvider(ref.watch(boxA)));
