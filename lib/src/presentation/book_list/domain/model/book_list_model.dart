

import 'package:sajha_prakasan/src/core/api.dart';

class BookListModel {
  int? appUserBookListID;
  int? appUserID;
  int? bookEditionID;
  String? bookInfo;
  int? bookID;
  String? edition;
  String? bookNameEnglish;
  String? bookNameNepali;
  int? languageID;
  String? language;
  int? publisherID;
  String? publisherName;
  int? publishedYearBS;
  int? publishedYearAD;
  num? price;
  String? pages;
  String? isbn;
  int? coverImageID;
  String? imageName;
  String? imagePath;
  int? pressID;
  String? pressName;
  int? planID;
  bool? planType;
  String? validFrom;
  String? validTo;
  List<Genres>? genres;
  List<Authors>? authors;

  BookListModel(
      {this.appUserBookListID,
        this.appUserID,
        this.bookEditionID,
        this.bookID,
        this.edition,
        this.bookNameEnglish,
        this.bookNameNepali,
        this.languageID,
        this.language,
        this.publisherID,
        this.publisherName,
        this.publishedYearBS,
        this.publishedYearAD,
        this.price,
        this.pages,
        this.isbn,
        this.coverImageID,
        this.imageName,
        this.imagePath,
        this.pressID,
        this.pressName,
        this.planID,
        this.planType,
        this.validFrom,
        this.validTo,
        this.genres,
        this.authors,
        this.bookInfo,
      });

  BookListModel.fromJson(Map<String, dynamic> json) {
    appUserBookListID = json['appUserBookListID'];
    appUserID = json['appUserID'];
    bookEditionID = json['bookEditionID'];
    bookID = json['bookID'];
    edition = json['edition'];
    bookNameEnglish = json['book_Name_English'];
    bookNameNepali = json['book_Name_Nepali'];
    languageID = json['languageID'];
    language = json['language'];
    publisherID = json['publisherID'];
    publisherName = json['publisherName'];
    publishedYearBS = json['publishedYearBS'];
    publishedYearAD = json['publishedYearAD'];
    price = json['price'];
    pages = json['pages'];
    isbn = json['isbn'];
    coverImageID = json['coverImageID'];
    imageName = json['imageName'];
    imagePath = '${Api.baseUrl}/${json['imagePath']}';
    pressID = json['pressID'];
    pressName = json['pressName'];
    planID = json['planID'];
    planType = json['planType'];
    validFrom = json['validFrom'];
    validTo = json['validTo'];
    bookInfo = json["bookInfo"];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
    if (json['authors'] != null) {
      authors = <Authors>[];
      json['authors'].forEach((v) {
        authors!.add(Authors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appUserBookListID'] = appUserBookListID;
    data['appUserID'] = appUserID;
    data['bookEditionID'] = bookEditionID;
    data['bookID'] = bookID;
    data['edition'] = edition;
    data['book_Name_English'] = bookNameEnglish;
    data['book_Name_Nepali'] = bookNameNepali;
    data['languageID'] = languageID;
    data['language'] = language;
    data['publisherID'] = publisherID;
    data['publisherName'] = publisherName;
    data['publishedYearBS'] = publishedYearBS;
    data['publishedYearAD'] = publishedYearAD;
    data['price'] = price;
    data['pages'] = pages;
    data['isbn'] = isbn;
    data['coverImageID'] = coverImageID;
    data['imageName'] = imageName;
    data['imagePath'] = imagePath;
    data['pressID'] = pressID;
    data['pressName'] = pressName;
    data['planID'] = planID;
    data['planType'] = planType;
    data['validFrom'] = validFrom;
    data['validTo'] = validTo;
    data['bookInfo'] = bookInfo;
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    if (authors != null) {
      data['authors'] = authors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Genres {
  int? genreID;
  String? genreNepali;
  String? genreEnglish;

  Genres({this.genreID, this.genreNepali, this.genreEnglish});

  Genres.fromJson(Map<String, dynamic> json) {
    genreID = json['genreID'];
    genreNepali = json['genre_Nepali'];
    genreEnglish = json['genre_English'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['genreID'] = genreID;
    data['genre_Nepali'] = genreNepali;
    data['genre_English'] = genreEnglish;
    return data;
  }
}

class Authors {
  int? authorID;
  String? authorNameEnglish;
  String? authorNameNepali;
  String? shortBio;
  int? roleID;
  String? roleEnglish;
  String? roleNepali;

  Authors(
      {this.authorID,
        this.authorNameEnglish,
        this.authorNameNepali,
        this.shortBio,
        this.roleID,
        this.roleEnglish,
        this.roleNepali});

  Authors.fromJson(Map<String, dynamic> json) {
    authorID = json['authorID'];
    authorNameEnglish = json['author_Name_English'];
    authorNameNepali = json['author_Name_Nepali'];
    shortBio = json['shortBio'];
    roleID = json['roleID'];
    roleEnglish = json['role_English'];
    roleNepali = json['role_Nepali'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authorID'] = authorID;
    data['author_Name_English'] = authorNameEnglish;
    data['author_Name_Nepali'] = authorNameNepali;
    data['shortBio'] = shortBio;
    data['roleID'] = roleID;
    data['role_English'] = roleEnglish;
    data['role_Nepali'] = roleNepali;
    return data;
  }
}