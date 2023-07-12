



import 'package:sajha_prakasan/src/presentation/book_list/domain/service/book_rating_service.dart';

class BookRatingProvider{


  Future<String> addRating({required String token, required int bookId, required int userId, required int rating})async{

    final response = await BookRatingService.rateBook(token: token, bookId: bookId, appUserId: userId, rating: rating);

    if(response.success == true){
      return 'success';
    }else{
      return response.errors!;
    }
  }

}