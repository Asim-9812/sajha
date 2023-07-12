


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajha_prakasan/src/presentation/payment/domain/model/checkout_book_model.dart';
import 'package:sajha_prakasan/src/presentation/payment/domain/service/check_out_service.dart';


final checkOutProvider = FutureProvider((ref) => CheckOutProvider());


class CheckOutProvider{

  Future<String> checkOut(List<CheckoutBook> items) async{
    final response = await CheckOutService.bookCheckout(items);
    return response;
  }

}