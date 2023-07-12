import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/presentation/detail/domain/model/book_model.dart';

class BookInfo {
  final int bookID;
  final String bookNameNepali;
  final String bookNameEnglish;
  final String bookInfo;
  final String imagePath;
  String? publisherName;
  final List<Genre> genres;
  int? tFavourite;

  BookInfo({
    required this.bookID,
    required this.bookNameNepali,
    required this.bookNameEnglish,
    required this.bookInfo,
    required this.imagePath,
    required this.genres,
    this.publisherName,
    this.tFavourite
  });


  factory BookInfo.fromJson(Map<String, dynamic> json){
    List<Genre> genreList = <Genre>[];
    json['genres'].forEach((v) {
      genreList.add(Genre.fromJson(v));
    });
    return BookInfo(
      bookID: json['bookID'],
      bookNameNepali: json['book_Name_Nepali'],
      bookNameEnglish: json['book_Name_English'],
      bookInfo: json['bookInfo'],
      imagePath: '${Api.baseUrl}/${json['imagePath']}',
      genres: genreList,
      publisherName: json["publisherName"] ?? '',
      tFavourite: json["tFavourite"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookID'] = bookID;
    data['book_Name_Nepali'] = bookNameNepali;
    data['book_Name_English'] = bookNameEnglish;
    data['bookInfo'] = bookInfo;
    data['imagePath'] = imagePath;
    data['genres'] = genres.map((v) => v.toJson()).toList();
    data['tFavourite'] = tFavourite;
    data['publisherName'] = publisherName;
    return data;
  }
}