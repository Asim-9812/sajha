import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sajha_prakasan/main.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/domain/model/book_model.dart';


final favListProvider = StateNotifierProvider<FavoriteLocalProvider, List<int>>((ref) => FavoriteLocalProvider(ref.watch(boxC)));


class FavoriteLocalProvider extends StateNotifier<List<int>>{
  FavoriteLocalProvider(super.state);

  Future<String> addToFavorite(int bookId, int bookInfoId) async{
    if(state.isEmpty){
      final newFavItem = bookId;
      Hive.box<int>('favoriteBooks').add(newFavItem);
      state = [newFavItem];
      return 'success';
    }else{
      final favItem = state.firstWhere((element) => element == bookId, orElse: (){
        return 0;
      });
      if(favItem == 0){
        final newFavItem = bookInfoId;
        Hive.box<int>('favoriteBooks').add(newFavItem);
        state = [...state,  newFavItem];
        return 'success';
      }else{
        return 'failed to add book';
      }
    }
  }

  void removeItem(int favItem, int index) {
    final box = Hive.box<int>('favoriteBooks');
    box.deleteAt(index);
    state.remove(favItem);
    state = [...state];
  }

  void clear(){
    Hive.box<int>('favoriteBooks').clear();
    state = [];
  }

}