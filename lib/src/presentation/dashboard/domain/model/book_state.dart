

import 'package:sajha_prakasan/src/presentation/dashboard/domain/model/book_model.dart';

class BookState{
  final String errText;
  final List<BookInfo> books;
  final bool isLoad;
  final String apiPath;
  final bool isLoadMore;

  BookState({
    required this.books,
    required this.apiPath,
    required this.errText,
    required this.isLoad,
    required this.isLoadMore,
  });

  BookState copyWith({required BookState bookState, String? errText, List<BookInfo>? books,
    bool? isLoad, String? apiPath, bool? isLoadMore}){
    return BookState(
        books: books ?? bookState.books,
        isLoad: isLoad ?? bookState.isLoad,
        errText: errText ??  bookState.errText,
        apiPath: apiPath ?? bookState.apiPath,
        isLoadMore:  isLoadMore ?? bookState.isLoadMore
    );
  }

}