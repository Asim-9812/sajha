import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/domain/model/book_model.dart';


final genreSearchProvider = FutureProvider.family((ref, String genre) => GenreSearchProvider().getBookByGenre(genre: genre));

final testProvider = StateProvider((ref) => GenreSearchProvider());

class GenreSearchProvider {
  final dio = Dio();

  Future<List<BookInfo>> getBookByGenre({required String genre}) async {
    try {
      final response = await dio.post(
        '${Api.searchByGenre}/$genre',
        queryParameters: {
          "genre": genre
        }
      );

      if (response.statusCode == 200 &&
          response.data["returnMsg"]["success"] == true) {
        final data = (response.data["details"] as List)
            .map((e) => BookInfo.fromJson(e))
            .toList();
        return data;
      } else {
        return [];
      }
    } on DioError catch (err) {
      throw err.message.toString();
    }
  }
}
