
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sajha_prakasan/main.dart';
import 'package:sajha_prakasan/src/presentation/detail/domain/model/book_model.dart';
import 'package:sajha_prakasan/src/presentation/cart/domain/model/cart.dart';


final cartProvider = StateNotifierProvider<CartProvider, List<Cart>>((ref) => CartProvider(ref.watch(boxB)));


class CartProvider extends StateNotifier<List<Cart>>{
  CartProvider(super.state);

  Future<String> addToCart(BookDetails book, Editions bookEdition) async{
    if(state.isEmpty){
      final newCartItem = Cart(
          bookEditionId: bookEdition.bookEditionID!,
          bookName: '${book.bookNameEnglish}',
          imageUrl: '${book.imagePath}',
          price: bookEdition.price!,
          edition: bookEdition.edition!,
      );
      Hive.box<Cart>('cart').add(newCartItem);
      state = [newCartItem];
      return 'success';
    }else{
      final cartItem = state.firstWhere((element) => element.bookEditionId == bookEdition.bookEditionID!, orElse: (){
        return Cart(bookEditionId: 0, price: 0, bookName: 'no-data', imageUrl: '', edition: '');
      });
      if(cartItem.bookName == 'no-data'){
        final newCartItem = Cart(
          bookEditionId: bookEdition.bookEditionID!,
          bookName: book.bookNameEnglish.toString(),
          imageUrl: book.imagePath.toString(),
          price: bookEdition.price!,
          edition: bookEdition.edition!,
        );
        Hive.box<Cart>('cart').add(newCartItem);
        state = [...state,  newCartItem];
        return 'success';
      }else{
        return 'fail';
      }
    }
  }

  num get getTotal  {
    num total = 0;
    for (final cartItem in state) {
      total += cartItem.price;
    }
    return total;
  }

  void removeItem(Cart cartItem) {
    cartItem.delete();
    state.remove(cartItem);
    state = [...state];
  }

  void clear(){
    Hive.box<Cart>('cart').clear();
    state = [];
  }

}
