import 'package:sajha_prakasan/src/core/api.dart';



class FavoriteBook {
  int? favouriteID;
  int? bookID;
  String? bookNameEnglish;
  String? bookNameNepali;
  String? bookInfo;
  int? originalLanguageID;
  String? language;
  int? publisherID;
  String? publisherName;
  int? bookImageID;
  String? imageName;
  String? imagePath;
  num? avgRating;
  int? tRating;
  int? tComment;
  int? tFavourite;

  FavoriteBook(
      {this.favouriteID,
        this.bookID,
        this.bookNameEnglish,
        this.bookNameNepali,
        this.bookInfo,
        this.originalLanguageID,
        this.language,
        this.publisherID,
        this.publisherName,
        this.bookImageID,
        this.imageName,
        this.imagePath,
        this.avgRating,
        this.tRating,
        this.tComment,
        this.tFavourite,
       });

  FavoriteBook.fromJson(Map<String, dynamic> json) {
    favouriteID = json['favouriteID'] ?? 0;
    bookID = json['bookID'] ?? 0;
    bookNameEnglish = json['book_Name_English'] ?? "";
    bookNameNepali = json['book_Name_Nepali'] ?? "";
    bookInfo = json['bookInfo'] ?? "";
    originalLanguageID = json['originalLanguageID'];
    language = json['language'];
    publisherID = json['publisherID'];
    publisherName = json['publisherName'];
    bookImageID = json['bookImageID'];
    imageName = json['imageName'];
    imagePath = '${Api.baseUrl}${json['imagePath']}';
    avgRating = json['avgRating'] ?? 0;
    tRating = json['tRating'] ?? 0;
    tComment = json['tComment'];
    tFavourite = json['tFavourite'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['favouriteID'] = favouriteID;
  //   data['bookID'] = bookID;
  //   data['book_Name_English'] = bookNameEnglish;
  //   data['book_Name_Nepali'] = bookNameNepali;
  //   data['bookInfo'] = bookInfo;
  //   data['originalLanguageID'] = originalLanguageID;
  //   data['language'] = language;
  //   data['publisherID'] = publisherID;
  //   data['publisherName'] = publisherName;
  //   data['bookImageID'] = bookImageID;
  //   data['imageName'] = imageName;
  //   data['imagePath'] = imagePath;
  //   data['avgRating'] = avgRating;
  //   data['tRating'] = tRating;
  //   data['tComment'] = tComment;
  //   data['tFavourite'] = tFavourite;
  // }
}


