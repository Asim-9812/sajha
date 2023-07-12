
import 'package:sajha_prakasan/src/presentation/favorite/domain/model/favorite_book_model.dart';


class FavoriteState{

  final String errText;
  final List<FavoriteBook> favBooks;
  // final Map<String, int> favBookObj;
  final bool isLoad;

  FavoriteState({
    required this.favBooks,
    required this.isLoad,
    required this.errText,
  });

  FavoriteState copyWith({required FavoriteState favoriteState, String? errText, List<FavoriteBook>? favBooks,
    bool? isLoad}){
    return FavoriteState(
      favBooks: favBooks ?? favoriteState.favBooks,
      isLoad: isLoad ?? favoriteState.isLoad,
      errText: errText ??  favoriteState.errText,
    );
  }
}
