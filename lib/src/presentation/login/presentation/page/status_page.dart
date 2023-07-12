import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sajha_prakasan/src/presentation/dashboard/presentation/main_page.dart';
import 'package:sajha_prakasan/src/presentation/login/presentation/page/login_page.dart';
import 'package:sajha_prakasan/src/presentation/login/presentation/provider/user_provider.dart';



class StatusPage extends ConsumerWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userProvider);
    return userData.isEmpty ? const UserLoginView() : const MainView();
  }
}
