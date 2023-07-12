import 'package:hive/hive.dart';
part 'cart.g.dart';

@HiveType(typeId: 1)
class Cart extends HiveObject{
  @HiveField(0)
  int bookEditionId;

  @HiveField(1)
  String bookName;

  @HiveField(2)
  String imageUrl;

  @HiveField(3)
  num price;

  @HiveField(4)
  String edition;

  Cart({
    required this.bookEditionId,
    required this.bookName,
    required this.imageUrl,
    required this.price,
    required this.edition,
  });

  factory Cart.fromJson(Map<String, dynamic> json){
    return Cart(
        bookEditionId: json["bookEditionID"],
        bookName: json["bookName"],
        imageUrl: json["imageUrl"],
        price: json["price"],
        edition: json["edition"],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "bookEditionID": bookEditionId,
      "bookName": bookName,
      "imageUrl": imageUrl,
      "price": price,
      "edition": edition,
    };
  }

}