import 'package:sajha_prakasan/src/core/api.dart';



class BookDetails {
  int? bookID;
  String? bookNameEnglish;
  String? bookNameNepali;
  String? bookInfo;
  int? originalLanguageID;
  int? rateCount;
  int? commentCount;
  String? language;
  int? publisherID;
  String? publisherName;
  int? bookImageID;
  String? imageName;
  String? imagePath;
  int? genreID;
  num? avgRating;
  String? genreNepali;
  String? genreEnglish;
  List<Authors>? authors;
  List<Editions>? editions;
  List<Genre>? genreList;
  List<Comment>? commentList;

  BookDetails({
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
    this.genreID,
    this.genreNepali,
    this.genreEnglish,
    this.authors,
    this.editions,
    this.genreList,
    this.commentList,
    this.avgRating,
    this.rateCount,
    this.commentCount,
  });

  BookDetails.fromJson(Map<String, dynamic> json) {
    bookID = json['bookID'];
    bookNameEnglish = json['book_Name_English'];
    bookNameNepali = json['book_Name_Nepali'];
    bookInfo = json['bookInfo'];
    originalLanguageID = json['originalLanguageID'];
    language = json['language'];
    publisherID = json['publisherID'];
    publisherName = json['publisherName'];
    bookImageID = json['bookImageID'];
    imageName = json['imageName'];
    imagePath = '${Api.baseUrl}/${json['imagePath']}';
    genreID = json['genreID'];
    genreNepali = json['genre_Nepali'];
    genreEnglish = json['genre_English'];
    avgRating = json["avgRating"] ?? 0;
    rateCount = json["tRating"] ?? 0;
    commentCount = json["tComment"] ?? 0;
    if (json['genres'] != null) {
      genreList = <Genre>[];
      json['genres'].forEach((v) {
        genreList!.add(Genre.fromJson(v));
      });
    }
    if (json['authors'] != null) {
      authors = <Authors>[];
      json['authors'].forEach((v) {
        authors!.add(Authors.fromJson(v));
      });
    }
    if (json['editions'] != null) {
      editions = <Editions>[];
      json['editions'].forEach((v) {
        editions!.add(Editions.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      commentList = <Comment>[];
      json['comments'].forEach((v) {
        commentList!.add(Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookID'] = bookID;
    data['book_Name_English'] = bookNameEnglish;
    data['book_Name_Nepali'] = bookNameNepali;
    data['bookInfo'] = bookInfo;
    data['originalLanguageID'] = originalLanguageID;
    data['language'] = language;
    data['publisherID'] = publisherID;
    data['publisherName'] = publisherName;
    data['bookImageID'] = bookImageID;
    data['imageName'] = imageName;
    data['imagePath'] = imagePath;
    data['genreID'] = genreID;
    data['genre_Nepali'] = genreNepali;
    data['genre_English'] = genreEnglish;
    if (genreList != null) {
      data['genres'] = genreList!.map((v) => v.toJson()).toList();
    }
    if (authors != null) {
      data['authors'] = authors!.map((v) => v.toJson()).toList();
    }
    if (editions != null) {
      data['editions'] = editions!.map((v) => v.toJson()).toList();
    }
    if (commentList != null) {
      data['genres'] = commentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Authors {
  int? authorID;
  String? authorNameEnglish;
  String? authorNameNepali;
  int? roleID;
  String? roleEnglish;
  String? roleNepali;
  String? shortBio;

  Authors({
    this.authorID,
    this.authorNameEnglish,
    this.authorNameNepali,
    this.roleID,
    this.roleEnglish,
    this.roleNepali,
    this.shortBio
  });

  Authors.fromJson(Map<String, dynamic> json) {
    authorID = json['authorID'];
    authorNameEnglish = json['author_Name_English'];
    authorNameNepali = json['author_Name_Nepali'];
    roleID = json['roleID'];
    roleEnglish = json['role_English'];
    roleNepali = json['role_Nepali'];
    shortBio = json['shortBio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authorID'] = authorID;
    data['author_Name_English'] = authorNameEnglish;
    data['author_Name_Nepali'] = authorNameNepali;
    data['roleID'] = roleID;
    data['role_English'] = roleEnglish;
    data['role_Nepali'] = roleNepali;
    data['shortBio'] = shortBio;
    return data;
  }
}

class Editions {
  int? bookEditionID;
  String? edition;
  String? isbn;
  num? price;
  int? publishedYearAD;
  int? publishedYearBS;

  Editions(
      {this.bookEditionID,
        this.edition,
        this.isbn,
        this.price,
        this.publishedYearAD,
        this.publishedYearBS});

  Editions.fromJson(Map<String, dynamic> json) {
    bookEditionID = json['bookEditionID'];
    edition = json['edition'];
    isbn = json['isbn'];
    price = json['price'];
    publishedYearAD = json['publishedYearAD'];
    publishedYearBS = json['publishedYearBS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookEditionID'] = bookEditionID;
    data['edition'] = edition;
    data['isbn'] = isbn;
    data['price'] = price;
    data['publishedYearAD'] = publishedYearAD;
    data['publishedYearBS'] = publishedYearBS;
    return data;
  }
}

class Genre {
  final int genreID;
  final String genreNepali;
  final String genreEnglish;

  Genre({
    required this.genreID,
    required this.genreNepali,
    required this.genreEnglish,
  });

  factory Genre.fromJson(Map<String, dynamic> json){
    return Genre(
      genreID: json["genreID"],
      genreEnglish: json["genre_English"],
      genreNepali: json["genre_Nepali"],
    );
  }

 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['genreID'] = genreID;
    data['genre_Nepali'] = genreNepali;
    data['genre_English'] = genreEnglish;
    return data;
 }

}

class Comment {
  int? appUserID;
  String? fName;
  String? lName;
  String? profilePicUrl;
  int? commentID;
  String? comments;
  String? createdDateTime;
  bool? status;
  int? ratingID;
  int? rating;

  Comment(
      {this.appUserID,
        this.fName,
        this.lName,
        this.profilePicUrl,
        this.commentID,
        this.comments,
        this.createdDateTime,
        this.status,
        this.ratingID,
        this.rating});

  Comment.fromJson(Map<String, dynamic> json) {
    appUserID = json['appUserID'];
    fName = json['fName'];
    lName = json['lName'];
    profilePicUrl = json['profilePicUrl'];
    commentID = json['commentID'];
    comments = json['comments'];
    createdDateTime = json['createdDateTime'];
    status = json['status'];
    ratingID = json['ratingID'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appUserID'] = appUserID;
    data['fName'] = fName;
    data['lName'] = lName;
    data['profilePicUrl'] = profilePicUrl;
    data['commentID'] = commentID;
    data['comments'] = comments;
    data['createdDateTime'] = createdDateTime;
    data['status'] = status;
    data['ratingID'] = ratingID;
    data['rating'] = rating;
    return data;
  }
}