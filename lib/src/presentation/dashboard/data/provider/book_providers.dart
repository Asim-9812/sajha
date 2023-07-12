
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/domain/model/book_model.dart';
import 'package:sajha_prakasan/src/presentation/detail/domain/model/book_model.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/domain/model/book_state.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/domain/service/book_service.dart';




final bookProvider = StateNotifierProvider<BookListProvider, BookState>((ref) => BookListProvider(BookState(
    books: [], isLoad: false, errText: '', apiPath: Api.bookInfo, isLoadMore: false)));


class BookListProvider extends StateNotifier<BookState>{
  BookListProvider(super.state){
    getBookData();
  }

  Future<void> getBookData() async{
    state = state.copyWith(bookState: state, isLoad: true);
    final data = await BookService.getBookByCategory(apiPath: state.apiPath);
    data.fold((l) {
      state = state.copyWith(bookState: state, errText: l, isLoad: false);
    },  (r) {
      state = state.copyWith(bookState: state, isLoad: false,books: [...state.books, ...r],errText: '');
    });
  }

  void changeCategory({required String apiPath}) {
    state = state.copyWith(bookState: state, apiPath: apiPath, books: [], isLoadMore: false,);
    getBookData();
  }

}