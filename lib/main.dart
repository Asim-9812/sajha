import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sajha_prakasan/src/app/app.dart';
import 'package:sajha_prakasan/src/presentation/cart/domain/model/cart.dart';
import 'package:sajha_prakasan/src/presentation/login/domain/model/user.dart';


final boxA = Provider<List<User>>((ref) => []);
final boxB = Provider<List<Cart>>((ref) => []);
final boxC = Provider<List<int>>((ref) => []);

late Box userBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
      )
  );

  await Hive.initFlutter();
  Hive.registerAdapter<User>(UserAdapter());
  Hive.registerAdapter<Cart>(CartAdapter());
  await Hive.openBox<String>('bookData');
  await Hive.openBox<String>('tokenBox');
  final userSession = await Hive.openBox<User>('session');
  final cartBox = await Hive.openBox<Cart>('cart');
  userBox = await Hive.openBox('user');
  final favListBox = await Hive.openBox<int>('favoriteBooks');
  runApp(
    ProviderScope(
      overrides: [
        boxA.overrideWithValue(userSession.values.toList()),
        boxB.overrideWithValue(cartBox.values.toList()),
        boxC.overrideWithValue(favListBox.values.toList()),
      ],
      child: MainApp(),
    ),
  );
}
