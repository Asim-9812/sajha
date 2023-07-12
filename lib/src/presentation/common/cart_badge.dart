import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sajha_prakasan/src/presentation/cart/data/provider/cart_provider.dart';
import 'package:sajha_prakasan/src/presentation/cart/presentation/cart_page.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';


class CartBadge extends ConsumerWidget {
  const CartBadge({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartData = ref.watch(cartProvider);
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          IconButton(
            onPressed: () {
              Get.to(() => const CartPage());
            },
            icon: Icon(
              cartData.isEmpty ? Icons.shopping_cart_outlined : Icons.shopping_cart_sharp,
              size: 30,
              color: Colors.black,
            ),
          ),
          Positioned(
            top: 2,
            right: 5,
            child: SizedBox(
              height: 20,
              width: 20,
              child: Badge(
                backgroundColor: Colors.red,
                label: Text('${cartData.length}'),
                isLabelVisible: cartData.isEmpty ? false : true, /// if cart is empty then the lable is set to false else its true and shows label
                largeSize: 20,
                textStyle: getMediumStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}