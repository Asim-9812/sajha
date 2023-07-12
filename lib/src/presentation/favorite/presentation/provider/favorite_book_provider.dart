




import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajha_prakasan/src/presentation/favorite/data/provider/favorite_provider.dart';

final addFavoriteProvider = StateProvider((ref) => FavoriteProvider());

final favoriteBooksProvider = FutureProvider.autoDispose((ref) => FavoriteProvider().getFavoriteBooks());

final removeFavBookProvider = StateProvider((ref) => FavoriteProvider());